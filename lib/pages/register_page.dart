import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart'; // Import halaman LoginPage

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key); // Perbaikan 1: Tambahkan key

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  late SharedPreferences logindata;
  bool newuser = true; // Perbaikan 3: Tidak perlu menggunakan late

  @override
  void initState() {
    super.initState(); // Perbaikan 2: Panggil super.initState() sebelum pengecekan login
    checkIfAlreadyLogin();
  }

  void checkIfAlreadyLogin() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      newuser = (logindata.getBool('login') ?? true);
    });
    if (!newuser) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"), // Tambahkan const pada teks yang tidak berubah
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Form Register", // Tambahkan const pada teks yang tidak berubah
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
                if (username != '' && password != '') {
                  print('Successfull');
                  logindata.setString('username', username);
                  logindata.setString('password', password);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                }
              },
              child: const Text("Register"), // Tambahkan const pada teks yang tidak berubah
            )
          ],
        ),
      ),
    );
  }
}
