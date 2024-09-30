import 'package:bank_calculator/constants/colors.dart';
import 'package:bank_calculator/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentSchedulePage extends StatelessWidget {
  final List<Map<String, dynamic>> payments;

  PaymentSchedulePage({required this.payments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts().paymentTable, style: Theme.of(context).textTheme.titleLarge,),
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, top: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              headingRowColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered))
                      return Colors.grey[300]!;
                    return Theme.of(context).cardColor!; // Başlık satır rengi
                  }),
              dataRowColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected))
                      return Colors.blue[100]!; // Satır seçildiğinde renk
                    return AppColor().orangeAccentColor.withOpacity(.4); // Varsayılan satır rengi
                  }),
              columnSpacing: 40, // Sütunlar arası boşluk
              horizontalMargin: 20, // Yatay kenar boşluğu
              border: TableBorder.all(width: 2, color: Colors.orange.shade100),
              columns: [
                DataColumn(label: Text('Month', style: GoogleFonts.poppins(fontSize: 20, color: Colors.orange, fontWeight: FontWeight.w500),)),
                DataColumn(label: Text('Date', style: GoogleFonts.poppins(fontSize: 20, color: Colors.orange, fontWeight: FontWeight.w500))),
                DataColumn(label: Text('Interest', style: GoogleFonts.poppins(fontSize: 20, color: Colors.orange, fontWeight: FontWeight.w500))),
                DataColumn(label: Text('Principal', style: GoogleFonts.poppins(fontSize: 20, color: Colors.orange, fontWeight: FontWeight.w500))),
                DataColumn(label: Text('Remaining', style: GoogleFonts.poppins(fontSize: 20, color: Colors.orange, fontWeight: FontWeight.w500))),
              ],
              rows: payments.map((payment) {
                return DataRow(
                  cells: [
                    DataCell(Text(payment['month'].toString(), style: GoogleFonts.lato(color: Colors.orange.shade100, fontWeight: FontWeight.w500, fontSize: 18),)),
                    DataCell(Text(payment['date'], style: GoogleFonts.lato(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18))),
                    DataCell(Text(payment['interest'].toStringAsFixed(2) + ' \$', style: GoogleFonts.lato(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18))),
                    DataCell(Text(payment['principal'].toStringAsFixed(2) + ' \$', style: GoogleFonts.lato(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18))),
                    DataCell(Text(payment['remaining'].toStringAsFixed(2) + ' \$', style: GoogleFonts.lato(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18))),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
