import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'log/login_page.dart';
import 'log/home_page.dart';
import 'log/session_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  bool loggedIn = await SessionManager.isLoggedIn();

  runApp(MyApp(loggedIn: loggedIn));
}

class MyApp extends StatelessWidget {
  final bool loggedIn;
  const MyApp({super.key, required this.loggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
     home: loggedIn 
    ? HomePage(fullName: "User") 
    : const LoginPage(),

    );
  }
}