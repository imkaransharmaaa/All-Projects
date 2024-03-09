// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison

import 'package:expenses_app/database/crud_user.dart';
import 'package:expenses_app/pages/home.dart';
import 'package:expenses_app/pages/register_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget
{
  const LoginScreen({Key? key}) : super(key: key);
  
  @override
  State<LoginScreen> createState() => _Login();
}
class _Login extends State<LoginScreen>
{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.zero,
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("Login", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                      SizedBox(height: 18),
                      Text("Login to yur account", style: TextStyle(fontSize: 18, color: Colors.grey[700])),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        inputFile(label: "Email", controller: emailController),
                        inputFile(label: "Password", obscureText: true, controller: passwordController)
                      ],
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      color: Color(0xff0095FF),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                      ),
                      onPressed: () {
                        print(emailController.text);
                        print(passwordController.text);
                        CRUDUser.checkLoginData(emailController.text, passwordController.text, context).then((value) {
                          if(value.email ==  emailController.text)
                          {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                          }
                        });
                      },
                      child: Text("Login", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen(),));
                        },
                        child: Text("Register", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.black))
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 100),
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/background.png'),
                        fit: BoxFit.fitHeight
                      )
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget inputFile({label, obscureText = false, controller})
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87)),
        SizedBox(height: 5),
        TextField(
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              //borderRadius: BorderRadius.zero,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              //borderRadius: BorderRadius.zero,
            ),
          ),
        ),
        SizedBox(height: 10)
      ],
    );
  }

}
