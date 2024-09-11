import 'package:bank_calculator/constants/assets.dart';
import 'package:bank_calculator/constants/colors.dart';
import 'package:bank_calculator/screens/payment_shedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/texts.dart';
import '../controllers/calculator_controller.dart';

class HomeScreen extends StatelessWidget {
  final CalculatorController controller = Get.put(CalculatorController());

  @override
  Widget build(BuildContext context) {
    var _w = MediaQuery.of(context).size.width;
    var _h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts().appTitle, style: Theme.of(context).textTheme.displayLarge!.copyWith(color: AppColor().orangeColor),),
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.settings))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:  SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(Colors.black26, BlendMode.overlay),
                    image: AssetImage(AppAssets().moneys),
                    fit: BoxFit.cover,
                    opacity: .13,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(colors: [AppColor().orangeColor, Colors.red])
                ),
                alignment: Alignment.center,
                child: Obx(
                    ()=> Text("${controller.krediTutari.value.toInt()} \$",
                      style: GoogleFonts.roboto(color: CupertinoColors.white, fontSize: 40, fontWeight: FontWeight.w500 )),
                ),
                height: _h/5,
                width: _w,

              ),
              SizedBox(height: 15,),
              Container(
                alignment: Alignment.center,
                child:TextField(
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).textTheme.titleLarge!.color,
                      fontSize: 25,
                      fontWeight: FontWeight.w500
                  ),
          onChanged: (value) => controller.krediTutari.value = double.tryParse(value) ?? 0.0,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Theme.of(context).primaryColorLight),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none
          ),
          labelText: AppTexts().creditAmount,
                ),
                keyboardType: TextInputType.number,
              ),
                width: _w,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).cardColor
                ),
              ),
              SizedBox(height: 15,),
              Container(
                alignment: Alignment.center,
                width: _w,
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardColor
                ),
                child: TextField(
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).textTheme.titleLarge!.color,
                      fontSize: 25,
                      fontWeight: FontWeight.w500
                  ),
                  onChanged: (value) => controller.faizOrani.value = double.tryParse(value) ?? 0.0,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Theme.of(context).primaryColorLight),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none
                    ),
                    labelText: AppTexts().interestRate,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 15,),
              Container(
                alignment: Alignment.center,
                width: _w,
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardColor
                ),
                child: TextField(
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).textTheme.titleLarge!.color,
                      fontSize: 25,
                      fontWeight: FontWeight.w500
                  ),
                  onChanged: (value) => controller.vadeSuresi.value = int.tryParse(value) ?? 0,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Theme.of(context).primaryColorLight),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none
                    ),
                    labelText: AppTexts().loanTerm,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 15,),
              Container(
                alignment: Alignment.center,
                width: _w,
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardColor
                ),
                child: Obx(() {
                  return TextField(
                    style: GoogleFonts.poppins(
                        color: Theme.of(context).textTheme.titleLarge!.color,
                        fontSize: 25,
                        fontWeight: FontWeight.w500
                    ),
                    controller: TextEditingController(
                      text: controller.baslangicTarihi.value.toLocal().toString().split(' ')[0], // YYYY-MM-DD formatı
                    ),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Theme.of(context).primaryColorLight),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                      labelText: "DateTime",
                      hintText: 'YYYY-MM-DD',
                    ),
                    readOnly: true,
                    onTap: () => _selectDate(context),
                  );
                }),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Obx(() => DropdownButton<String>(
                  underline: SizedBox(),
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
              ),
              SizedBox(height: 15,),
               Obx(() {
                  if (controller.selectedKomisyonTipi.value != AppTexts().noCommission) {
                    return Container(
                      alignment: Alignment.center,
                      width: _w,
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).cardColor
                      ),
                      child: TextField(
                        cursorOpacityAnimates: true,
                        style: GoogleFonts.poppins(
                            color: Theme.of(context).textTheme.titleLarge!.color,
                            fontSize: 25,
                            fontWeight: FontWeight.w500
                        ),
                        onChanged: (value) => controller.komisyonTutari.value = double.tryParse(value) ?? 0.0,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Theme.of(context).primaryColorLight),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none),
                          labelText: controller.selectedKomisyonTipi.value == AppTexts().interestCommission
                              ? AppTexts().commissionRate
                              : AppTexts().commissionAmount,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    );
                  } else {
                    return Container(
                      alignment: Alignment.center,
                    );
                  }
                }),
            ],
          ),
        )
      ),
      floatingActionButton: FilledButton.icon(
        style: FilledButton.styleFrom(
          maximumSize: Size(_w-100, 50),
          minimumSize: Size(_w-100, 50)
        ),
        onPressed: () {
           controller.hesaplaKredi();
          _showBottomSheet(context, _w);},
        label: Text("Calculate", style: TextStyle(fontSize: 20),),
        icon: Icon(Icons.calculate),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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

  void _showBottomSheet(BuildContext context, double _w) {
    showModalBottomSheet(
      backgroundColor: AppColor().scaffColor,
      context: context,
      builder: (context) {
        return SizedBox(
          width: _w,
          child: Padding(
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
          ),
        );});
  }
}
