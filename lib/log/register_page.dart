import 'package:flutter/material.dart';
import 'user_data.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class PasswordState {
  static bool obsPass = true;
  static bool obsConfirmPass = true;
}

class _RegisterPageState extends State<RegisterPage> {
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _register() {
    String fullName = _fullNameController.text;
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    final emailError = Validators.validateEmail(email);
    final passwordError = Validators.validatePassword(password);
    final usernameError = Validators.validateUsername(username);

    if (fullName.isEmpty || username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showErrorDialog('Registrasi Gagal', 'Harap isi semua kolom.');
    } else if (emailError != null) {
      _showErrorDialog('Registrasi Gagal', emailError);
    } else if (passwordError != null) {
      _showErrorDialog('Registrasi Gagal', passwordError);
    } else if (usernameError != null) {
      _showErrorDialog('Registrasi Gagal', usernameError);
    } else if (password != confirmPassword) {
      _showErrorDialog('Registrasi Gagal', 'Kata sandi tidak cocok.');
    } else {
      userData[email] = {
        'fullName': fullName,
        'username': username,
        'password': password,
      };
      _showSuccessDialog();
    }
  }

  void _showErrorDialog(String title, String content) {
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

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registrasi Berhasil'),
        content: const Text('Akun Anda telah dibuat. Silakan login.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
              Navigator.pop(context); 
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Hero(
                  tag: 'logo',
                  child: Icon(
                    Icons.shopping_bag,
                    size: 80,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Create Account',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Join us today!',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
                const SizedBox(height: 30),
                _buildTextField(_fullNameController, 'Fullname', Icons.person_outline),
                const SizedBox(height: 20),
                _buildTextField(_usernameController, 'Username', Icons.person_outline),
                const SizedBox(height: 20),
                _buildTextField(_emailController, 'Email', Icons.email_outlined, keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 20),
                _buildPasswordTextField(_passwordController, 'Password', PasswordState.obsPass, (value) {
                  setState(() {
                    PasswordState.obsPass = value;
                  });
                }),
                const SizedBox(height: 20),
                _buildPasswordTextField(_confirmPasswordController, 'Confirm Password', PasswordState.obsConfirmPass, (value) {
                  setState(() {
                    PasswordState.obsConfirmPass = value;
                  });
                }),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Register', style: TextStyle(fontSize: 18)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.black54),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, IconData icon, {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey.shade200,
        prefixIcon: Icon(icon, color: Colors.black54),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPasswordTextField(TextEditingController controller, String hintText, bool obscureText, Function(bool) onVisibilityChanged) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey.shade200,
        prefixIcon: const Icon(Icons.lock_outline, color: Colors.black54),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.black54,
          ),
          onPressed: () => onVisibilityChanged(!obscureText),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class Validators {
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email tidak boleh kosong.';
    }
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Masukkan email yang valid.';
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Kata sandi tidak boleh kosong.';
    }
    if (value.length < 6) {
      return 'Kata sandi harus minimal 6 karakter.';
    }
    return null;
  }

  static String? validateUsername(String value) {
    if (value.isEmpty) {
      return 'Username tidak boleh kosong.';
    }
    if (value.length < 3) {
      return 'Username harus minimal 3 karakter.';
    }
    return null;
  }
}
