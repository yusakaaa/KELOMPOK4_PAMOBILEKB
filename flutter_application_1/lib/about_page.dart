import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Penguin Species Predictor'),
        backgroundColor: Colors.blue[800],
      ),
      body: Container(
        // Menambahkan warna atau gambar di background
        decoration: BoxDecoration(
          color: Colors.lightBlue[50], // Ganti dengan warna atau gambar
          // Jika ingin menggunakan gambar background:
          // image: DecorationImage(
          //   image: AssetImage('assets/images/background.jpg'), // Ganti dengan path gambar Anda
          //   fit: BoxFit.cover,
          // ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              // Judul Deskripsi
              Text(
                'Deskripsi Aplikasi',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              SizedBox(height: 10),
              // Deskripsi Aplikasi
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Penguin Species Predictor adalah aplikasi yang dirancang untuk membantu pengguna memprediksi spesies penguin berdasarkan data fisik seperti panjang paruh, lebar paruh, panjang sayap, dan berat badan. Aplikasi ini menggunakan kecerdasan buatan untuk memberikan hasil prediksi yang akurat.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
              ),
              SizedBox(height: 20),
              
              // Fitur Utama
              Text(
                'Fitur Utama:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• Prediksi spesies penguin berdasarkan data input.', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 6),
                      Text('• Visualisasi hasil prediksi yang mudah dipahami.', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 6),
                      Text('• Interaktif dan mudah digunakan.', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              
              // Pengembang
              Text(
                'Pengembang:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Dikembangkan oleh [Nama Pengembang].',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
              ),
              SizedBox(height: 20),
              
              // Lisensi dan Kredit
              Text(
                'Lisensi & Kredit:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Aplikasi ini menggunakan dataset penguin yang tersedia di [Sumber Data] dan framework XGBoost.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
              ),
              SizedBox(height: 20),
              
              // Footer
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '© 2024 [Nama Pengembang]. All Rights Reserved.',
                    style: TextStyle(fontSize: 14, color: Colors.black45),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
