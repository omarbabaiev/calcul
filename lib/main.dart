import 'dart:math'; // Pow fonksiyonunu kullanmak için eklendi
import 'package:flutter/material.dart';

void main() {
  runApp(KrediHesaplamaApp());
}

class KrediHesaplamaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kredi Faizi Hesaplama',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: KrediHesaplamaScreen(),
    );
  }
}

class KrediHesaplamaScreen extends StatefulWidget {
  @override
  _KrediHesaplamaScreenState createState() => _KrediHesaplamaScreenState();
}

class _KrediHesaplamaScreenState extends State<KrediHesaplamaScreen> {
  final TextEditingController _krediTutariController = TextEditingController();
  final TextEditingController _faizOraniController = TextEditingController();
  final TextEditingController _vadeSuresiController = TextEditingController();

  double _aylikOdeme = 0.0;
  double _toplamOdeme = 0.0;
  double _toplamFaizParasi = 0.0;


  void hesaplaKredi() {
    double krediTutari = double.tryParse(_krediTutariController.text) ?? 0.0;
    double faizOrani = (double.tryParse(_faizOraniController.text) ?? 0.0) / 100 / 12;
    int vadeSuresi = int.tryParse(_vadeSuresiController.text) ?? 0;

    if (krediTutari > 0 && faizOrani > 0 && vadeSuresi > 0) {
      // Pow fonksiyonu dart:math paketinden geliyor
      double aylikOdeme = krediTutari * faizOrani / (1 - pow(1 + faizOrani, -vadeSuresi));
      double toplamOdeme = aylikOdeme * vadeSuresi;

      setState(() {
        _aylikOdeme = aylikOdeme;
        _toplamOdeme = toplamOdeme;
        _toplamFaizParasi = toplamOdeme - krediTutari;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kredi Faizi Hesaplama'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _krediTutariController,
              decoration: InputDecoration(
                labelText: 'Kredi Tutarı',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _faizOraniController,
              decoration: InputDecoration(
                labelText: 'Faiz Oranı (%)',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _vadeSuresiController,
              decoration: InputDecoration(
                labelText: 'Vade Süresi (Ay)',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: hesaplaKredi,
              child: Text('Hesapla'),
            ),
            SizedBox(height: 20),
            if (_aylikOdeme > 0)
              Text('Aylık Ödeme: ${_aylikOdeme.toStringAsFixed(2)}₺'),
            if (_aylikOdeme > 0)
              Text('Toplam faiz parası: ${_toplamFaizParasi.toStringAsFixed(2)}₺'),
            if (_toplamOdeme > 0)
              Text('Toplam Ödeme: ${_toplamOdeme.toStringAsFixed(2)}₺'),
          ],
        ),
      ),
    );
  }
}
