import 'package:flutter/material.dart';
import 'home_screen.dart'; // Mengarahkan ke halaman utama setelah login

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Penguin Species Predictor',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: HomeScreen(onThemeChanged: (bool ) {  },), // Halaman utama (selamat datang)
    );
  }
}
