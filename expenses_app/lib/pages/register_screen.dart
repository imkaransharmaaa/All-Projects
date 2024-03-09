// ignore_for_file: prefer_const_constructors

import 'package:expenses_app/database/crud_user.dart';
import 'package:expenses_app/model/User.dart';
import 'package:expenses_app/pages/login_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget
{
  const RegisterScreen({Key? key}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => _Register();
  
}

class _Register extends State<RegisterScreen>
{

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height/1.3,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Registration", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  SizedBox(height: 18),
                  Text("Create an account, It's free", style: TextStyle(fontSize: 18, color: Colors.grey[700])),
                ],
              ),
              Column(
                children: <Widget>[
                  inputFile(label: "Name", controller: nameController),
                  inputFile(label: "Email", controller: emailController),
                  inputFile(label: "Mobile Number", controller: mobileController),
                  inputFile(label: "Password", obscureText: true, controller: passwordController)
                ],
              ),
              MaterialButton(
                minWidth: double.infinity,
                height: 60,
                color: Color(0xff0095FF),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
                ),
                onPressed: () {
                  CRUDUser.addUsers(User(name: nameController.text, email: emailController.text, password: passwordController.text, mobile: mobileController.text)).whenComplete(() {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registered successfully !!!"), backgroundColor: Colors.green,));
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  });
                },
                child: Text("Register", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white)),
              ),
            ]
          )
        ),
      )
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