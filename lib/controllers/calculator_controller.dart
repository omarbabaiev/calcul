import 'dart:math';
import 'package:get/get.dart';
import '../constants/texts.dart';

class CalculatorController extends GetxController {
  var krediTutari = 0.0.obs;
  var faizOrani = 0.0.obs;
  var vadeSuresi = 0.obs;
  var komisyonTutari = 0.0.obs;
  var selectedKomisyonTipi = AppTexts().noCommission.obs;
  var aylikOdeme = 0.0.obs;
  var toplamOdeme = 0.0.obs;
  var toplamFaizParasi = 0.0.obs;
  var baslangicTarihi = DateTime.now().obs; // Başlangıç tarihi

  List<String> komisyonTipleri = [AppTexts().noCommission, AppTexts().interestCommission, AppTexts().fixedCommission];
  List<String> odemeTarihleri = List.generate(12, (index) => '').obs;

  void hesaplaKredi() {
    double faiz = (faizOrani.value / 100) / 12;
    double kredi = krediTutari.value;
    int vade = vadeSuresi.value;
    double komisyon = komisyonTutari.value;

    if (selectedKomisyonTipi.value == AppTexts().interestCommission) {
      kredi += kredi * komisyon / 100;
    } else if (selectedKomisyonTipi.value == AppTexts().fixedCommission) {
      kredi += komisyon;
    }

    if (kredi > 0 && faiz > 0 && vade > 0) {
      double aylik = kredi * faiz / (1 - pow(1 + faiz, -vade));
      double toplam = aylik * vade;

      aylikOdeme.value = aylik;
      toplamOdeme.value = toplam;
      toplamFaizParasi.value = toplam - krediTutari.value;
    }
  }

  List<Map<String, dynamic>> generatePaymentSchedule() {
    List<Map<String, dynamic>> payments = [];
    double remaining = krediTutari.value;
    double monthlyPayment = aylikOdeme.value;
    double interestRate = (faizOrani.value / 100) / 12;
    DateTime currentDate = baslangicTarihi.value;

    for (int month = 1; month <= vadeSuresi.value; month++) {
      double interestPayment = remaining * interestRate;
      double principalPayment = monthlyPayment - interestPayment;
      remaining -= principalPayment;

      payments.add({
        'month': month,
        'date': currentDate.toLocal().toString().split(' ')[0], // YYYY-MM-DD formatı
        'interest': interestPayment,
        'principal': principalPayment,
        'remaining': remaining > 0 ? remaining : 0,
      });

      currentDate = DateTime(currentDate.year, currentDate.month + 1, currentDate.day);
    }

    return payments;
  }
}
