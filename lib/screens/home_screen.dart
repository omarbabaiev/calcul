import 'package:bank_calculator/constants/assets.dart';
import 'package:bank_calculator/constants/colors.dart';
import 'package:bank_calculator/screens/result_screen.dart';
import 'package:bank_calculator/screens/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_corner/smooth_corner.dart';
import '../constants/texts.dart';
import '../controllers/calculator_controller.dart';
import 'package:flutter_share/flutter_share.dart';

class HomeScreen extends StatelessWidget {
  final CalculatorController controller = Get.put(CalculatorController());
  TextEditingController _textController = TextEditingController();
  Future<void> shareLink() async {
    await FlutterShare.share(
        title: 'Download CalCul from Play Store',
        linkUrl: AppTexts().link,
        chooserTitle: 'Share via'
    );
  }

  @override
  Widget build(BuildContext context) {
    var _w = MediaQuery.of(context).size.width;
    var _h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts().appTitle,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: AppColor().orangeAccentColor),),
        actions: [
          IconButton(onPressed: (){
          shareLink();
        }, icon: Icon(Icons.share))],
        iconTheme: IconThemeData(color: Colors.white,),
        // leading: IconButton(
        //     onPressed: (){
        //       Get.to(()=>SettingsScreen(), fullscreenDialog: true);
        //     },
        //     icon: Text(AppTexts().appTitle,
        //       style: Theme.of(context).textTheme.displayLarge!.copyWith(
        //           color: AppColor().orangeAccentColor),)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:  SingleChildScrollView(
          child: Column(
            children: [
              Animate(
                effects: [FadeEffect(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                )],
                child: Container(
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(Colors.black26, BlendMode.overlay),
                      image: AssetImage(AppAssets().moneys),
                      fit: BoxFit.cover,
                      opacity: .13,
                    ),
                    gradient: LinearGradient(colors: [AppColor().orangeColor.withOpacity(.9), Colors.red.withOpacity(.9)]),
                    shape: SmoothRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                      smoothness: 0.9,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Obx(
                      ()=> Text("${controller.krediTutari2.value.toInt()} \$",
                        style: GoogleFonts.roboto(color: CupertinoColors.white, fontSize: 40, fontWeight: FontWeight.w500 )),
                  ),
                  height: _h/5,
                  width: _w,

                ),
              ),
              SizedBox(height: 20,),
              Animate(
                effects: [
                  SlideEffect(duration: Duration(milliseconds: 300)),
                  FadeEffect(duration: Duration(milliseconds: 300)),
                ],
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  alignment: Alignment.center,
                  child:TextField(
                    style: GoogleFonts.poppins(
                        color: Theme.of(context).textTheme.titleLarge!.color,
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),
                          onChanged: (value){
                            controller.krediTutari.value = double.tryParse(value) ?? 0.0;
                            controller.krediTutari2.value = double.tryParse(value) ?? 0.0;
                          },
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.attach_money_outlined, color: Theme.of(context).disabledColor,),
                    labelStyle: GoogleFonts.poppins(color: AppColor().orangeAccentColor, fontSize: 18, fontWeight: FontWeight.w500),
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
                  decoration: ShapeDecoration(
                    color: Theme.of(context).cardColor,
                    shape: SmoothRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      smoothness: 0.9,
                    ),
                  ),

                ),
              ),
              SizedBox(height: 15,),
              Animate(
                effects: [
                  SlideEffect(duration: Duration(milliseconds: 300)),
                  FadeEffect(duration: Duration(milliseconds: 300)),
                ],
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  alignment: Alignment.center,
                  width: _w,
                  height: 60,
                  decoration: ShapeDecoration(
                    color: Theme.of(context).cardColor,
                    shape: SmoothRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      smoothness: 0.9,
                    ),
                  ),
                  child: TextField(
                    style: GoogleFonts.poppins(
                        color: Theme.of(context).textTheme.titleLarge!.color,
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),
                    onChanged: (value) => controller.faizOrani.value = double.tryParse(value) ?? 0.0,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.percent, color: Theme.of(context).disabledColor,),
                      labelStyle: GoogleFonts.poppins(color: AppColor().orangeAccentColor, fontSize: 18, fontWeight: FontWeight.w500),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none
                      ),
                      labelText: AppTexts().interestRate,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              SizedBox(height: 15,),
      Animate(
        effects: [
          SlideEffect(duration: Duration(milliseconds: 300)),
          FadeEffect(duration: Duration(milliseconds: 300)),
        ],
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.center,
                    width: _w,
                    height: 60,
                    decoration: ShapeDecoration(
                    color: Theme.of(context).cardColor,
                    shape: SmoothRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    smoothness: 0.9,
                    ),
                    ),
                    child: TextField(
                    controller: _textController,
                    readOnly: true,
                    style: GoogleFonts.poppins(
                    color: Theme.of(context).textTheme.titleLarge!.color,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    ),
                    onTap: () {
                    _showCupertinoPicker(context, _w);
                    },
                    decoration: InputDecoration(
                    suffixIcon: Icon(Icons.calendar_month, color: Theme.of(context).disabledColor),
                    labelStyle: GoogleFonts.poppins(
                    color: AppColor().orangeAccentColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    ),
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                    ),
                    hintText: AppTexts().loanTerm,
                    ),
                    keyboardType: TextInputType.number,
                    ),
                    ),
              ),
              SizedBox(height: 15,),
      Animate(
        effects: [
          SlideEffect(duration: Duration(milliseconds: 300)),
          FadeEffect(duration: Duration(milliseconds: 300)),
        ], child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  alignment: Alignment.center,
                  width: _w,
                  height: 60,
                  decoration: ShapeDecoration(
                    color: Theme.of(context).cardColor,
                    shape: SmoothRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      smoothness: 0.9,
                    ),
                  ),
                  child: Obx(() {
                    return TextField(
                      style: GoogleFonts.poppins(
                          color: Theme.of(context).textTheme.titleLarge!.color,
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                      ),
                      controller: TextEditingController(
                        text: controller.baslangicTarihi.value.toLocal().toString().split(' ')[0], // YYYY-MM-DD formatı
                      ),
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.calendar_view_day, color: Theme.of(context).disabledColor,),
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
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Obx(() => DropdownButton<String>(
                  padding:  EdgeInsets.symmetric(horizontal: 10),
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
      Animate(
        effects: [
          SlideEffect(duration: Duration(milliseconds: 300)),
          FadeEffect(duration: Duration(milliseconds: 300)),
        ],
                 child: Obx(() {
                    if (controller.selectedKomisyonTipi.value != AppTexts().noCommission) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        alignment: Alignment.center,
                        width: _w,
                        height: 60,
                        decoration: ShapeDecoration(
                          color: Theme.of(context).cardColor,
                          shape: SmoothRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            smoothness: 0.9,
                          ),
                        ),
                        child: Obx(()=>TextField(
                            cursorOpacityAnimates: true,
                            style: GoogleFonts.poppins(
                                color: Theme.of(context).textTheme.titleLarge!.color,
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                            ),
                            onChanged: (value) => controller.komisyonTutari.value = double.tryParse(value) ?? 0.0,
                            decoration: InputDecoration(
                              suffixIcon: controller.selectedKomisyonTipi.value != AppTexts().fixedCommission
                                  ? Icon(Icons.percent, color: Theme.of(context).disabledColor,)
                                  : Icon(Icons.attach_money_outlined, color: Theme.of(context).disabledColor,),
                              labelStyle: GoogleFonts.poppins(color: AppColor().orangeAccentColor, fontSize: 18, fontWeight: FontWeight.w500),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none),
                              labelText: controller.selectedKomisyonTipi.value == AppTexts().interestCommission
                                  ? AppTexts().commissionRate
                                  : AppTexts().commissionAmount,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        alignment: Alignment.center,
                      );
                    }
                  }),
               ),
            ],
          ),
        )
      ),
      floatingActionButton:
      FilledButton.icon(
        style: FilledButton.styleFrom(
          maximumSize: Size(_w-100, 50),
          minimumSize: Size(_w-100, 50)
        ),
        onPressed: () {
          HapticFeedback.vibrate();
           controller.hesaplaKredi();
          _showBottomSheet(context, _w);},
        label: Text(AppTexts().calculate
          , style: TextStyle(fontSize: 18),),
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
      showDragHandle: true,
      backgroundColor: Color(0xff1c0e00),
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              opacity: .05,
                image: AssetImage(AppAssets().moneys)
            )
          ),
          width: _w,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.attach_money_rounded),
                          SizedBox(width: 10,),
                          Text("${AppTexts().monthlyPayment}", style: TextStyle(fontSize: 18, color: AppColor().orangeAccentColor),),
                        ],
                      ),
                      Text('${controller.aylikOdeme.value.toStringAsFixed(2)} \$', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor().orangeColor),),

                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.percent),
                          SizedBox(width: 10,),
                          Text("${AppTexts().totalInterest}", style: TextStyle(fontSize: 18, color: AppColor().orangeAccentColor),),
                        ],
                      ),
                      Text('${controller.toplamFaizParasi.value.toStringAsFixed(2)} \$', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor().orangeColor),),

                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          controller.selectedKomisyonTipi.value == AppTexts().interestCommission
                              ? Icon(Icons.percent)
                              : Icon(Icons.attach_money_outlined),
                          SizedBox(width: 10,),
                          Text("${AppTexts().commissionAmount}", style: TextStyle(fontSize: 18, color: AppColor().orangeAccentColor),),
                        ],
                      ),
                      controller.selectedKomisyonTipi.value == AppTexts().interestCommission
                          ? Text('${controller.komisyonTutari.value} \%', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor().orangeColor),)
                          : Text('${controller.komisyonTutari.value} \$', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor().orangeColor),),


                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_today),
                          SizedBox(width: 10,),
                          Text(AppTexts().loanTerm, style: TextStyle(fontSize: 18, color: AppColor().orangeAccentColor),),
                        ],
                      ),
                      Text('${controller.vadeSuresi.value}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor().orangeColor),),

                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Divider(color: AppColor().orangeAccentColor.withOpacity(.4),),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.do_not_disturb_on_total_silence),
                          SizedBox(width: 10,),
                          Text("${AppTexts().totalPayment}", style: TextStyle(fontSize: 18, color: AppColor().orangeAccentColor),),
                        ],
                      ),
                      Text('${controller.toplamOdeme.value.toStringAsFixed(2)} \$', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor().orangeColor),),

                    ],
                  ),
                ),
                SizedBox(height: 20),
                FilledButton.tonalIcon(
                  style: FilledButton.styleFrom(
                    shape:  SmoothRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                  smoothness: 0.9,
                ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Kapatma
                    Get.to(() => ResultScreen(), transition: Transition.cupertino);
                  },
                  icon: Icon(Icons.chevron_right),
                  label: Text(AppTexts().showDetails, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                ),
              ],
            ),
          ),
        );});
  }
  void _showCupertinoPicker(BuildContext context, double _w) {

    var _monthPickerController = FixedExtentScrollController();
    var _yearPickerController = FixedExtentScrollController();

    int selectedMonth = 0;
    int selectedYear = 0;

    showModalBottomSheet(
      backgroundColor: Color(0xff1c0e00),
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).size.height/2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(AppTexts().selectLoanTerm, style: TextStyle(fontSize: 20, color: AppColor().orangeAccentColor, fontWeight: FontWeight.bold),),
              Container(
                height: MediaQuery.of(context).size.height/3,
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: _w / 3,
                      child: CupertinoPicker(
                        scrollController: _yearPickerController,
                        itemExtent: 32.0,
                        backgroundColor: Colors.transparent,
                        onSelectedItemChanged: (int index) {
                          selectedYear = index;
                          HapticFeedback.selectionClick();
                        },
                        children: List<Widget>.generate(50, (int index) {
                          return Center(
                            child: Text('${index} ${AppTexts().year}', style: TextStyle(color: AppColor().orangeColor)),
                          );
                        }),
                      ),
                    ),
                    // Ay seçici
                    Container(
                      width: _w / 3,
                      child: CupertinoPicker(
                        scrollController: _monthPickerController,
                        itemExtent: 32.0,
                        backgroundColor: Colors.transparent,
                        onSelectedItemChanged: (int index) {
                          selectedMonth = index;
                          HapticFeedback.selectionClick();
                        },
                        children: List<Widget>.generate(12, (int index) {
                          return Center(
                            child: Text('${index } ${AppTexts().month}', style: TextStyle(color: AppColor().orangeColor)),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              FilledButton(
                style: FilledButton.styleFrom(minimumSize: Size(_w/2, 40)),
                  onPressed: (){
                    int totalMonths = selectedMonth + (selectedYear * 12);
                    controller.vadeSuresi.value = totalMonths;
                    _textController.text = '$totalMonths';
                    Navigator.of(context).pop();
                  }, child: Text(AppTexts().apply, style: TextStyle(fontSize: 22),))
            ],
          ),
        );
      },
    );
  }
}
