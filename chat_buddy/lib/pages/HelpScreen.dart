import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);
  @override
  State<Help> createState() => _HelpScreen();
}

class _HelpScreen extends State<Help>{
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text("Help", style: TextStyle(fontSize: 30)),
        ),
      ),
    );
  }
}