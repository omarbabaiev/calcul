import 'package:bank_calculator/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentSchedulePage extends StatelessWidget {
  final List<Map<String, dynamic>> payments;

  PaymentSchedulePage({required this.payments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ödeme Tablosu'),
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              border: TableBorder.all(width: 2, color: Colors.orange.shade100),
              columns: [
                DataColumn(label: Text('Ay', style: GoogleFonts.poppins(fontSize: 20, color: Colors.orange, fontWeight: FontWeight.w500),)),
                DataColumn(label: Text('Tarih', style: GoogleFonts.poppins(fontSize: 20, color: Colors.orange, fontWeight: FontWeight.w500))),
                DataColumn(label: Text('Faiz', style: GoogleFonts.poppins(fontSize: 20, color: Colors.orange, fontWeight: FontWeight.w500))),
                DataColumn(label: Text('Ana Para', style: GoogleFonts.poppins(fontSize: 20, color: Colors.orange, fontWeight: FontWeight.w500))),
                DataColumn(label: Text('Kalan Borç', style: GoogleFonts.poppins(fontSize: 20, color: Colors.orange, fontWeight: FontWeight.w500))),
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
