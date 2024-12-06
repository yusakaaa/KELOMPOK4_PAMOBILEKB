import 'package:flutter/material.dart';
import 'login_screen.dart'; // Navigasi ke halaman login

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false; // Menyimpan status dark mode

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: HomeScreen(
        onThemeChanged: (bool value) {
          setState(() {
            isDarkMode = value;
          });
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;

  HomeScreen({required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          Switch(
            value: Theme.of(context).brightness == Brightness.dark,
            onChanged: (bool value) {
              onThemeChanged(value);
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[200]!, Colors.blue[900]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.pets, size: 120, color: Colors.white),
              SizedBox(height: 20),
              Text(
                'Penguin Species Predictor',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 5,
                      color: Colors.black38,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 30),
                color: Colors.white.withOpacity(0.9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Prediksi spesies penguin berdasarkan karakteristik fisik mereka dengan akurasi tinggi.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.blue[800]),
                  ),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  },
  child: Text('Masuk'),
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
    backgroundColor: Colors.blue[800],
    foregroundColor: Colors.white, // Ubah warna teks menjadi putih
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    textStyle: TextStyle(fontSize: 18),
  ),
),

            ],
          ),
        ),
      ),
    );
  }
}
