import 'package:flutter/material.dart';
import 'user_data.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  void _recoverPassword() {
    final email = _emailController.text;
    if (email.isEmpty) {
      _showInfoDialog('Input Kosong', 'Silakan masukkan email Anda.');
      return;
    }

    if (userData.containsKey(email)) {
      final password = userData[email]!['password'];
      _showInfoDialog(
        'Kata Sandi Ditemukan',
        'Kata sandi Anda adalah: $password\n\n(Catatan: Menampilkan kata sandi secara langsung tidak aman dan hanya untuk tujuan demo.)',
      );
    } else {
      _showInfoDialog(
          'Email Tidak Ditemukan', 'Email yang Anda masukkan tidak terdaftar.');
    }
  }

  void _showInfoDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lupa Kata Sandi'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Masukkan email Anda untuk memulihkan kata sandi.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _recoverPassword,
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50)),
              child: const Text('Kirim'),
            ),
          ],
        ),
      ),
    );
  }
}
