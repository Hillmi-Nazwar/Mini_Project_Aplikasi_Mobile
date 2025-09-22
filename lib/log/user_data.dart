Map<String, Map<String, String>> userData = {
  'test@email.com': {
    'fullName': 'Test User',
    'password': 'pass123',
    'username': 'testuser'
  },
};

class PasswordState {
  static bool obsPass = true;
}

class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email tidak boleh kosong";
    }
    if (!value.contains('@') || !value.contains('.')) {
      return "Masukkan email yang valid";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password tidak boleh kosong";
    }
    if (value.length < 6) {
      return "Password minimal 6 karakter";
    }
    return null;
  }
}
