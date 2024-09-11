import 'package:bank_calculator/constants/colors.dart';
import 'package:bank_calculator/screens/payment_shedule.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/texts.dart';
import '../controllers/calculator_controller.dart';

class ResultScreen extends StatelessWidget {
  final CalculatorController controller = Get.put(CalculatorController());

  @override
  Widget build(BuildContext context) {
    var _w = MediaQuery.of(context).size.width;
    var _h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        // title: Text(AppTexts().appTitle, style: Theme.of(context).textTheme.displayLarge,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: _w,
              height: _h/5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(colors: [AppColor().orangeColor, Colors.red])
              ),
              child: Text(
                controller.krediTutari.value.toString(),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              onChanged: (value) => controller.krediTutari.value = double.tryParse(value) ?? 0.0,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 3
                    )
                ),
                labelText: AppTexts().creditAmount,
              ),
              keyboardType: TextInputType.number,
            ),

            // Faiz Oranı
            TextField(
              onChanged: (value) => controller.faizOrani.value = double.tryParse(value) ?? 0.0,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: AppTexts().interestRate,
              ),
              keyboardType: TextInputType.number,
            ),
            // Vade Süresi
            TextField(
              onChanged: (value) => controller.vadeSuresi.value = int.tryParse(value) ?? 0,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: AppTexts().loanTerm,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),

            // Başlangıç Tarihi
            Obx(() {
              return TextField(
                controller: TextEditingController(
                  text: controller.baslangicTarihi.value.toLocal().toString().split(' ')[0], // YYYY-MM-DD formatı
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "DateTime",
                  hintText: 'YYYY-MM-DD',
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
              );
            }),

            SizedBox(height: 20),

            // Komisyon Tipi Dropdown
            Obx(() => DropdownButton<String>(
              value: controller.selectedKomisyonTipi.value,
              items: controller.komisyonTipleri.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller.selectedKomisyonTipi.value = newValue;
                }
              },
            )),

            // Komisyon Tutarı/Oranı Girişi
            Obx(() {
              if (controller.selectedKomisyonTipi.value != AppTexts().noCommission) {
                return TextField(
                  onChanged: (value) => controller.komisyonTutari.value = double.tryParse(value) ?? 0.0,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: controller.selectedKomisyonTipi.value == AppTexts().interestCommission
                        ? AppTexts().commissionRate
                        : AppTexts().commissionAmount,
                  ),
                  keyboardType: TextInputType.number,
                );
              } else {
                return Container();
              }
            }),

            SizedBox(height: 20),

            // Hesapla Butonu
            ElevatedButton(
              onPressed: () {
                controller.hesaplaKredi();
                _showBottomSheet(context);
              },
              child: Text(AppTexts().calculate),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: controller.baslangicTarihi.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null && selectedDate != controller.baslangicTarihi.value) {
      controller.baslangicTarihi.value = selectedDate;
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${AppTexts().monthlyPayment}: ${controller.aylikOdeme.value.toStringAsFixed(2)}₺'),
              Text('${AppTexts().totalInterest}: ${controller.toplamFaizParasi.value.toStringAsFixed(2)}₺'),
              Text('${AppTexts().totalPayment}: ${controller.toplamOdeme.value.toStringAsFixed(2)}₺'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Kapatma
                  Get.to(() => PaymentSchedulePage(payments: controller.generatePaymentSchedule()));
                },
                child: Text('Kredi Tablosu Görüntüle'),
              ),
            ],
          ),
        );
      },
    );
  }
}
