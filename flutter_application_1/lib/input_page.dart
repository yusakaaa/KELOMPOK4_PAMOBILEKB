import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'TampilanHome.dart'; // Impor halaman utama
import 'prediction_result_page.dart'; // Impor halaman hasil prediksi
import 'about_page.dart'; // Impor halaman About

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InputPage(),
    );
  }
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final _formKey = GlobalKey<FormState>();
  double culmenLength = 0.0;
  double culmenDepth = 0.0;
  double flipperLength = 0.0;
  double bodyMass = 0.0;
  int selectedSex = 1; // Ganti string 'Male' menjadi int 1 untuk Male
  bool isLoading = false;
  int _selectedIndex = 0; // Menyimpan index halaman yang dipilih untuk BottomNavigationBar
  bool isDarkMode = false; // Menyimpan status dark mode

  // Fungsi untuk memproses data dan prediksi
  Future<void> predictSpecies() async {
    setState(() {
      isLoading = true; // Tampilkan indikator loading
    });

    final url = 'https://07a2-36-85-7-122.ngrok-free.app/predict'; // Ganti dengan URL ngrok Anda
    final body = {
      'features': {
        'culmen_length_mm': culmenLength,
        'culmen_depth_mm': culmenDepth,
        'flipper_length_mm': flipperLength,
        'body_mass_g': bodyMass,
        'sex': selectedSex, // Mengirimkan nilai 1 atau 0
      },
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      print("Status code: ${response.statusCode}");
      print("Body respons: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final prediction = data['prediction'];

        print("Prediksi: $prediction");

        // Arahkan ke halaman hasil prediksi dengan data hasil
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PredictionResultPage(
              prediction: prediction,
              culmenLength: culmenLength,
              culmenDepth: culmenDepth,
              flipperLength: flipperLength,
              bodyMass: bodyMass,
              selectedSex: selectedSex, // Menampilkan jenis kelamin sesuai nilai
            ),
          ),
        );
      } else {
        showErrorDialog('Error: ${response.body}');
      }
    } catch (e) {
      print("Error terjadi: $e");
      showErrorDialog('Terjadi kesalahan: $e');
    } finally {
      setState(() {
        isLoading = false; // Sembunyikan indikator loading setelah selesai
      });
    }
  }

  // Dialog kesalahan
  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Form input field untuk setiap data penguin
  Widget buildInputField(String label, Function(String) onChanged) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Field tidak boleh kosong';
        }
        return null;
      },
    );
  }

  // Fungsi untuk mengubah halaman berdasarkan item navbar yang dipilih
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      // Navigasi ke Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TampilanHome()), // Navigasi ke halaman Home
      );
    } else if (index == 1) {
      // Navigasi ke halaman Prediksi Spesies (InputPage)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => InputPage()),
      );
    } else if (index == 2) {
      // Navigasi ke halaman About
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AboutPage()), // Navigasi ke halaman About
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(), // Menentukan tema berdasarkan status isDarkMode
      home: Scaffold(
        appBar: AppBar(
          title: Text('Input Data Penguin'),
          backgroundColor: Colors.blue,
          actions: [
            Switch(
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value; // Mengubah status dark mode
                });
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Masukkan data penguin untuk prediksi spesies',
                  style: TextStyle(fontSize: 18, color: Colors.lightBlue[700]),
                ),
                SizedBox(height: 20),
                buildInputField('Panjang Paruh (mm)', (value) {
                  culmenLength = double.parse(value);
                }),
                buildInputField('Lebar Paruh (mm)', (value) {
                  culmenDepth = double.parse(value);
                }),
                buildInputField('Panjang Sayap (mm)', (value) {
                  flipperLength = double.parse(value);
                }),
                buildInputField('Berat Badan (g)', (value) {
                  bodyMass = double.parse(value);
                }),
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(labelText: 'Jenis Kelamin'),
                  value: selectedSex,
                  items: [
                    DropdownMenuItem(value: 1, child: Text('Male')), // Kirimkan 1 untuk Male
                    DropdownMenuItem(value: 0, child: Text('Female')), // Kirimkan 0 untuk Female
                  ],
                  onChanged: (newValue) {
                    setState(() {
                      selectedSex = newValue!; // Set nilai berdasarkan pilihan (0 atau 1)
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      predictSpecies();
                    }
                  },
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('Prediksi Spesies'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue[900],
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                  ),
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => TampilanHome()), // Navigasi ke halaman Home
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.trending_up),
                title: Text('Prediksi Spesies'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => InputPage()), // Halaman Input Data
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()), // Halaman About
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up),
              label: 'Prediksi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'About',
            ),
          ],
        ),
      ),
    );
  }
}
