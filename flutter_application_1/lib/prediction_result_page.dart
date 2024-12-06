import 'package:flutter/material.dart';

class PredictionResultPage extends StatelessWidget {
  final String prediction;
  final double culmenLength;
  final double culmenDepth;
  final double flipperLength;
  final double bodyMass;
  final int selectedSex;

  PredictionResultPage({
    required this.prediction,
    required this.culmenLength,
    required this.culmenDepth,
    required this.flipperLength,
    required this.bodyMass,
    required this.selectedSex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Prediksi'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hasil Prediksi Spesies: $prediction',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Data yang dimasukkan:',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            SizedBox(height: 10),
            _buildInfoRow('Panjang Paruh (mm)', culmenLength.toString()),
            _buildInfoRow('Lebar Paruh (mm)', culmenDepth.toString()),
            _buildInfoRow('Panjang Sayap (mm)', flipperLength.toString()),
            _buildInfoRow('Berat Badan (g)', bodyMass.toString()),
            _buildInfoRow('Jenis Kelamin', selectedSex.toString()),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Kembali ke halaman sebelumnya
              },
              child: Text('Kembali ke Input Data'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk menampilkan informasi input dalam format baris
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
