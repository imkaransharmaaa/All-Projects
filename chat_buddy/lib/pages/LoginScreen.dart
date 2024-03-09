// ignore_for_file: invalid_return_type_for_catch_error, unnecessary_brace_in_string_interps, avoid_print, use_build_context_synchronously

import 'package:chat_buddy/Service/APIService.dart';
import 'package:chat_buddy/model/LoginModel.dart';
import 'package:chat_buddy/pages/ChangePassword.dart';
import 'package:chat_buddy/pages/HomeScreen.dart';
import 'package:chat_buddy/pages/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginSreen();
}

class _LoginSreen extends State<Login>
{
  String? spToken;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
    saveData();
  }

  void loadData() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? email = sp.getString("email");
    String? pass = sp.getString("pass");

    if(email != null && pass != null)
    {
      print(email);
      print(pass);
      print(sp.getString("token"));

      Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));

    }
  }

  void show()
  async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("email", emailController.text);
    sp.setString("pass", passwordController.text);

    print("${sp.getString("email")} and ${sp.getString("pass")} and ${sp.getString("token")}");
  }

  void saveData()
  async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("token", spToken!);

    print(sp.getString("token"));
  }

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
                  "Login Here !",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter User Email",
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter User Password",
                  ),
                ),
              ),
              Container(
                height: 60,
                padding: const EdgeInsets.fromLTRB(15, 2, 15, 2),
                child: ElevatedButton(
                  child: const Text("Login"),
                  onPressed: () {
                    //print(emailController.text);ail.com a
                    //print(passwordController.text);

                    show();

                    APIService apiService = APIService();
                    apiService.login(LoginRequest(emailController.text,passwordController.text)).then((value) {
                    
                    spToken = value.token!;
                    print(spToken);
                    saveData();
                    
                    print("Token is : ${value.token}");
                    
                    if(value.token!.isNotEmpty)
                    {
                       //spToken = value.token!;
                       //saveData();

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
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ForgetPassword()));
                },
                child: const Text("Forgot Password"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("If You have not any account ? "),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()));
                    },
                    child: const Text(
                      "Register Here !",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}