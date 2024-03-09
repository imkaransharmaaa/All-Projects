// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:expenses_app/database/DBHelper.dart';
import 'package:expenses_app/pages/login_screen.dart';
import 'package:expenses_app/pages/register_screen.dart';
import 'package:flutter/material.dart';

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
      title: "Expenses App",
      home: Scaffold(
        body: StartScreen(),
      ),
    );
  }
}

class StartScreen extends StatefulWidget
{
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StartPage();

}

class _StartPage extends State<StartScreen>
{
  @override
  void initState() {
    super.initState();
    var obj = DBHelper();
    obj.init();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    child: Text("Welcome",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35)),
                  ),
                  SizedBox(height: 18),
                  Container(
                    child: Text("Your day to day expenses manage by this app",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[900], fontSize: 15)),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height/3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/welcome.png')
                  )
                ),
              ),

              Column(
                children: <Widget>[
                  //Login Button
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
                    },
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.black
                      ),
                      borderRadius: BorderRadius.circular(54)
                    ),
                    child: Text("Login", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  ),

                  SizedBox(height: 20,),

                  //Registration Button
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen(),));
                    },
                    color: Color(0xff0095FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(54)
                    ),
                    child: Text("Registration", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),),
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }

}