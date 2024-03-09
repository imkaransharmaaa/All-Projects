// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:patient_app/pages/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget 
{
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget
{
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen>
{
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3)).then((value){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Patients Information App", style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 6, 44, 59), fontWeight: FontWeight.w600)),
            Container(
              height: MediaQuery.of(context).size.shortestSide,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/splash.jpg')
                )
              ),
            )
          ],
        ),
      ),
    );
  }

}