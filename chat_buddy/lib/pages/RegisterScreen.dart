// ignore_for_file: unnecessary_brace_in_string_interps, invalid_return_type_for_catch_error, avoid_print

import 'package:chat_buddy/Service/APIService.dart';
import 'package:chat_buddy/model/RegisterModel.dart';
import 'package:chat_buddy/pages/HomeScreen.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  @override
  State<Register> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(15),
                child: const Text(
                  "Code Better !",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 35),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(15),
                child: const Text(
                  "Register Here !",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter Name",
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter User Name",
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter User Password",
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: mobileController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter Mobile",
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: genderController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter User Gender",
                  ),
                ),
              ),
              Container(
                height: 60,
                padding: const EdgeInsets.fromLTRB(15, 2, 15, 2),
                child: ElevatedButton(
                  child: const Text("Register"),
                  onPressed: () {
                    print(nameController.text);
                    print(emailController.text);
                    print(mobileController.text);
                    print(passController.text);
                    print(genderController.text);

                    var name = nameController.text;
                    var email = emailController.text;
                    var password = passController.text;
                    var mobile = mobileController.text;
                    var gender = genderController.text;

                    APIService apiService = new APIService();
                    apiService.register(RegisterRequest(name,email,password,mobile,gender)).then((value) {
                            print("Value is : ${value.message}");
                            print("Value is : ${value.status}");
                          
                          if(value.status == true)
                          {
                             Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => const Home(),
                         )
                       );
                          }

                    }).catchError((err)=>print("Error is : ${err}"));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}