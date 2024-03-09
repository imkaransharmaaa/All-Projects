import 'package:chathub_app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget
{
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreen();
  
}

class _LoginScreen extends State<Login>
{
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  void initState() {
    super.initState();
    ShowData();
  }

  void SaveData()
  async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("email", email.text);
    sp.setString("pass", pass.text);
  }

  void ShowData()
  async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? spEmail = sp.getString("email");
    String? spPass = sp.getString("email");

    setState(() {
      email.text = spEmail!;
      pass.text = spPass!;
    });

    if(email.text.isNotEmpty && pass.text.isNotEmpty)
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("ChatHub")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.zero,
              child: const Text("Login Here !", style: TextStyle(color: Color.fromARGB(255, 236, 123, 31),fontSize: 30)),
            ),
            Container(
              padding: const EdgeInsets.only(top: 40, right: 25, left: 25, bottom: 10),
              child: TextField(
                controller: email,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter Email",
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10, right: 25, left: 25, bottom: 30),
              child: TextField(
                controller: pass,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter Password",
                ),
              ),
            ),
            Container(
              width: 120,
              height: 45,
              padding: EdgeInsets.zero,
              child: ElevatedButton(
                child: const Text("Login", style: TextStyle(fontSize: 22),),
                onPressed: () {
                  SaveData();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
                },
              )
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Are you not user?", style: TextStyle(fontSize: 21)),
                  TextButton(
                    child: const Text("Register here!", style: TextStyle(fontSize: 22)),
                    onPressed: () {
                      
                    },
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}