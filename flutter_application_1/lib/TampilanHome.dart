import 'package:flutter/material.dart';
import 'input_page.dart'; // Halaman input data penguin, ganti sesuai dengan nama file Anda

class TampilanHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penguin Species Predictor'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        // Menambahkan gambar latar belakang
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('penguein.jpg'), // Path gambar
            fit: BoxFit.cover, // Gambar akan menutupi seluruh layar
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),

              // Judul
              Text(
                'Selamat Datang di Penguin Species Predictor!',
                style: TextStyle(
                  fontSize: 22, 
                  fontWeight: FontWeight.bold, 
                  color: Colors.blue[800],
                  shadows: [
                    Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 5,
                      color: Colors.black38,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              Divider(color: Colors.blue, thickness: 2), // Divider
              SizedBox(height: 10),
              
              // Card untuk deskripsi tentang penguin
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors.blue[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Penguin adalah salah satu burung unik di dunia karena tidak dapat terbang. Mereka hidup terutama di belahan bumi selatan, dan setiap spesies memiliki cara adaptasi sendiri untuk bertahan dalam lingkungan ekstrem.',
                        style: TextStyle(fontSize: 16, color: Colors.blue[700]),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Mereka memiliki adaptasi khusus untuk hidup di lingkungan yang sangat dingin, seperti tubuh yang berbulu lebat dan lapisan lemak tebal.',
                        style: TextStyle(fontSize: 16, color: Colors.blue[600]),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Tombol untuk membuka penjelasan lebih lanjut
              ElevatedButton(
                onPressed: () {
                  // Tambahkan navigasi ke halaman baru atau modal yang lebih detail jika diperlukan
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Tentang Penguin'),
                        content: Text(
                          'Penguin memiliki adaptasi khusus untuk bertahan hidup di lingkungan ekstrem, seperti lapisan lemak dan bulu yang membantu mereka menjaga suhu tubuh tetap stabil. Mereka adalah simbol ketahanan hidup di belahan bumi selatan.',
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Tutup dialog
                            },
                            child: Text('Tutup'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Lebih Banyak Penjelasan', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  backgroundColor: Colors.blue[900],
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Tombol dengan ujung membulat
                  ),
                ),
              ),
              SizedBox(height: 20),
              
              // Tombol untuk Prediksi
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InputPage()), // Navigasi ke halaman input data penguin
                  );
                },
                icon: Icon(Icons.search, color: Colors.white), // Tambahkan ikon
                label: Text('Prediksi'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  backgroundColor: Colors.blue[900],
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Tombol dengan ujung membulat
                  ),
                ),
              ),
              SizedBox(height: 20),
              
              // Informasi tambahan tentang penguin
              Divider(color: Colors.blue, thickness: 2), // Divider kedua
              Text(
                'Terdapat berbagai spesies penguin, masing-masing dengan karakteristik unik. Aplikasi ini dapat membantu memprediksi spesies penguin berdasarkan ukuran tubuh dan ciri fisik lainnya.',
                style: TextStyle(fontSize: 16, color: Colors.blue[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Penguin Species Predictor',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Navigate to Home
              },
            ),
            ListTile(
              leading: Icon(Icons.trending_up), // Ikon untuk Prediksi
              title: Text('Prediksi Spesies'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InputPage()), // Halaman Input Data
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                // Arahkan ke halaman About atau info lainnya
              },
            ),
          ],
        ),
      ),
    );
  }
}
