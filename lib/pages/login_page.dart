import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsi_ifd/pages/register_page.dart';
import '../widgets/bottom_navigation.dart';
import 'home_page.dart'; // Import halaman Home

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key); // Perbaikan 1: Tambahkan key

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  late SharedPreferences logindata;
  bool newuser = true; // Perbaikan 2: Tidak perlu menggunakan late

  @override
  void initState() {
    super.initState();
    checkIfAlreadyLogin(); // Perbaikan 3: Ubah nama metode menjadi lowerCamelCase
  }

  void checkIfAlreadyLogin() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      newuser = (logindata.getBool('login') ?? true);
    });
    if (!newuser) { // Perbaikan 4: Periksa jika bukan new user sebelum navigasi
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"), // Tambahkan const pada teks yang tidak berubah
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Form Login", // Tambahkan const pada teks yang tidak berubah
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'username', // Tambahkan const pada teks yang tidak berubah
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password', // Tambahkan const pada teks yang tidak berubah
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String username = usernameController.text;
                String password = passwordController.text;
                if (username == logindata.getString('username') &&
                    password == logindata.getString('password')) {
                  print('Successful');
                  logindata.setBool('login', false);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                } else {
                  print('Login gagal!');
                }
              },
              child: const Text("Login"), // Tambahkan const pada teks yang tidak berubah
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: const Text('Tidak Punya akun? Register'), // Tambahkan const pada teks yang tidak berubah
            ),
          ],
        ),
      ),
    );
  }
}
