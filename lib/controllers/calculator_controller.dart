import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/texts.dart';

class CalculatorController extends GetxController {
  var krediTutari = 0.0.obs;
  var krediTutari2 = 0.0.obs;
  var faizOrani = 0.0.obs;
  var vadeSuresi = 0.obs;
  var komisyonTutari = 0.0.obs;
  var selectedKomisyonTipi = AppTexts().noCommission.obs;
  var aylikOdeme = 0.0.obs;
  var toplamOdeme = 0.0.obs;
  var toplamFaizParasi = 0.0.obs;
  var baslangicTarihi = DateTime.now().obs;

  List<String> komisyonTipleri = [AppTexts().noCommission, AppTexts().interestCommission, AppTexts().fixedCommission];
  var paymentSchedule = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    hesaplaKredi(); // İlk başta kredi hesaplaması yapılır.
    paymentSchedule.value = generatePaymentSchedule(); // Ödeme planı oluşturulur.
  }

  // Kredi Hesaplama
  void hesaplaKredi() {
    // Check for null values and assign default values
    double faiz = ((faizOrani.value ?? 0) / 100) / 12; // If faizOrani is null, default to 0
    double kredi = krediTutari.value ?? 0; // If krediTutari is null, default to 0
    int vade = vadeSuresi.value ?? 0; // If vadeSuresi is null, default to 0
    double komisyon = komisyonTutari.value ?? 0; // If komisyonTutari is null, default to 0

    // Update the loan amount based on the selected commission type
    if (selectedKomisyonTipi.value == AppTexts().interestCommission) {
      kredi += kredi * komisyon / 100;
    } else if (selectedKomisyonTipi.value == AppTexts().fixedCommission) {
      kredi += komisyon;
    }

    // Only proceed with the calculation if all values are valid
    if (kredi > 0 && faiz > 0 && vade > 0) {
      double aylik = kredi * faiz / (1 - pow(1 + faiz, -vade));
      double toplam = aylik * vade;

      // Round and assign the calculated values
      aylikOdeme.value = roundToTwoDecimals(aylik);
      toplamOdeme.value = roundToTwoDecimals(toplam);
      toplamFaizParasi.value = roundToTwoDecimals(toplam - krediTutari.value);

    } else {
      // Show a warning if any value is invalid

    }

    // Recalculate the payment schedule
    paymentSchedule.value = generatePaymentSchedule();
  }


  // Ödeme Planı Oluşturma
  List<Map<String, dynamic>> generatePaymentSchedule() {
    List<Map<String, dynamic>> payments = [];
    double remaining = krediTutari.value;
    double monthlyPayment = roundToTwoDecimals(aylikOdeme.value);
    double interestRate = (faizOrani.value / 100) / 12;
    DateTime currentDate = baslangicTarihi.value;

    for (int month = 1; month <= vadeSuresi.value; month++) {
      double interestPayment = roundToTwoDecimals(remaining * interestRate);
      double principalPayment = roundToTwoDecimals(monthlyPayment - interestPayment);
      remaining = roundToTwoDecimals(remaining - principalPayment);

      if (month == vadeSuresi.value) {
        remaining = 0.0; // Son ayda kalan borcu sıfırla
      }

      payments.add({
        'month': month,
        'date': currentDate.toLocal().toString().split(' ')[0], // YYYY-MM-DD
        'interest': interestPayment,
        'principal': principalPayment,
        'remaining': remaining,
      });

      currentDate = DateTime(currentDate.year, currentDate.month + 1, currentDate.day);
    }

    return payments;
  }

  // Extra ödeme sonrası planı güncelleme
  void updateScheduleWithExtraPayment(double extraPayment, int startIndex) {
    var krediTutari2 = krediTutari;
    List<Map<String, dynamic>> updatedSchedule = paymentSchedule.value;
    double remainingDebt = updatedSchedule[startIndex]['remaining'] - extraPayment; // İlk olarak borçtan ek ödemeyi düş
    double faiz = (faizOrani.value / 100) / 12;
    double newMonthlyPayment;

    // Eğer kalan borç negatifse sıfıra ayarla
    if (remainingDebt < 0) {
      remainingDebt = 0;
    }

    // Ek ödeme sonrası aylık ödemeyi yeniden hesapla
    newMonthlyPayment = roundToTwoDecimals(remainingDebt * faiz / (1 - pow(1 + faiz, -(vadeSuresi.value - startIndex - 1))));

    // Ek ödeme yapılan aya extraPayment değerini ekle
    updatedSchedule[startIndex]['extraPayment'] = extraPayment;

    // Eğer yeni aylık ödeme hesaplandıysa, ödeme planını yeniden hesapla
    for (int i = startIndex + 1; i < vadeSuresi.value; i++) {
      if (remainingDebt <= 0) {
        // Eğer borç kalmadıysa, sonraki aylar için tüm değerleri sıfırla
        updatedSchedule[i]['interest'] = 0;
        updatedSchedule[i]['principal'] = 0;
        updatedSchedule[i]['remaining'] = 0;
      } else {
        // Kalan borç üzerinden faiz ve ana para hesapla
        double interestPayment = roundToTwoDecimals(remainingDebt * faiz);
        double principalPayment = roundToTwoDecimals(newMonthlyPayment - interestPayment);

        // Eğer son ayda ödenecek miktar kalan borçtan fazla ise, kalan borcu sıfırla ve negatif değerleri önle
        if (principalPayment > remainingDebt) {
          principalPayment = remainingDebt;
        }

        // Borcu güncelle
        remainingDebt = roundToTwoDecimals(remainingDebt - principalPayment);

        // Planı güncelle
        updatedSchedule[i]['interest'] = interestPayment;
        updatedSchedule[i]['principal'] = principalPayment;
        updatedSchedule[i]['remaining'] = remainingDebt;
      }
    }

    // Ek ödeme sonrası kalan kredi tutarını güncelle
    krediTutari.value -= extraPayment;
    if (krediTutari.value < 0) {
      krediTutari.value = 0; // Borç sıfıra indiyse negatif olmaması için sıfıra ayarla
    }

    // Kredi hesaplamasını güncelle
    toplamOdeme.value = roundToTwoDecimals(newMonthlyPayment * (vadeSuresi.value - startIndex - 1)); // Güncellenen toplam ödeme
    aylikOdeme.value = newMonthlyPayment; // Yeni aylık ödeme

    paymentSchedule.value = updatedSchedule; // Güncellenmiş planı set et
    paymentSchedule.refresh(); // GetX'e değişiklik olduğunu bildir
  }

  // Sayı yuvarlama
  double roundToTwoDecimals(double value) {
    return double.parse(value.toStringAsFixed(2));
  }
}
