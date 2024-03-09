import 'package:flutter/material.dart';

class Error extends StatefulWidget {
  const Error({Key? key}) : super(key: key);
  @override
  State<Error> createState() => _ErrorScreen();
}

class _ErrorScreen extends State<Error>{
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text("Error Screen...", style: TextStyle(fontSize: 30)),
        ),
      ),
    );
  }
}