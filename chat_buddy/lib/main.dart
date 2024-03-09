import 'package:chat_buddy/pages/LoginScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Design',
      home: Scaffold(
        appBar: AppBar(title: const Text("Login Design..")),
        body: const Login(),
      ),
    );
  }
}