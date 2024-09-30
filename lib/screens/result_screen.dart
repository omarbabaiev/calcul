import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/calculator_controller.dart';
import '../constants/colors.dart';
import '../constants/texts.dart';
import 'payment_shedule.dart';

class ResultScreen extends StatelessWidget {
  final CalculatorController controller = Get.put(CalculatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts().paymentTable, style: Theme.of(context).textTheme.titleLarge),
        iconTheme: IconThemeData(color: AppColor().orangeAccentColor),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => PaymentSchedulePage(payments: controller.paymentSchedule), fullscreenDialog: true);
            },
            icon: Icon(Icons.table_chart_outlined),
          )
        ],
      ),
      body: Obx(() {
      var paymentSchedule = controller.paymentSchedule;

      return paymentSchedule.length != 0 
          ? ListView.builder(
        itemCount: paymentSchedule.length,
        itemBuilder: (context, index) {
          var payment = paymentSchedule[index];
          return Stack(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child:  ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColor().orangeAccentColor,
                    child: Text(
                      payment['month'].toString(),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColor().scaffColor),
                    ),
                  ),
                  title: Obx(()=>
                      Text(
                      // Eğer ek ödeme varsa onu göster, yoksa aylık ödeme miktarını göster
                      paymentSchedule[index].containsKey('extraPayment')
                          ? 'Extra Payment: ${payment['extraPayment'].toStringAsFixed(2)}'
                          : (payment['interest'] + payment['principal']).toStringAsFixed(2),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColor().orangeColor,
                          fontSize: 20),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Interest: ${payment['interest'].toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16, color: Colors.white54, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        'Principal: ${payment['principal'].toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 15, color: Colors.white54),
                      ),
                      Text(
                        'Remaining Debt: ${payment['remaining'].toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 15, color: Colors.white54),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    color: AppColor().orangeAccentColor,
                    icon: Icon(Icons.add),
                    onPressed: () {
                      _showExtraPaymentDialog(context, index, payment['remaining']);
                    },
                  ),
                )),
              Positioned(
                top: 15,
                right: 20,
                child: Text(
                  '${payment['date']}',
                  style: TextStyle(fontSize: 14, color: Colors.white38),
                ),
              ),
            ],
          );
        },
      )
          : Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info_outlined, color: AppColor().orangeColor, ),
              Text("Not found", style: TextStyle(fontSize: 28, color: AppColor().orangeAccentColor, )),
            ],
          ));
    }),
    );
  }

  void _showExtraPaymentDialog(BuildContext context, int index, double remainingDebt) {
    final TextEditingController extraPaymentController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppTexts().extraPaymentTitle, style: TextStyle(fontSize: 20, color: Colors.white),),
          content: TextField(

            style: TextStyle(fontSize: 14, color: Colors.white),
            controller: extraPaymentController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: AppTexts().remainingHintText,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                double extraPayment = double.tryParse(extraPaymentController.text) ?? 0.0;
                if (extraPayment > 0) {
                  controller.updateScheduleWithExtraPayment(extraPayment, index);
                  Navigator.of(context).pop();
                }
              },
              child: Text(AppTexts().apply),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppTexts().cancel),
            ),
          ],
        );
      },
    );
  }
}
