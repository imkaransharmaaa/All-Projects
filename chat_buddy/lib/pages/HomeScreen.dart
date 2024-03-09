
import 'package:chat_buddy/pages/AboutScreen.dart';
import 'package:chat_buddy/pages/HelpScreen.dart';
import 'package:chat_buddy/pages/LoginScreen.dart';
import 'package:chat_buddy/pages/SettingScreen.dart';
import 'package:chat_buddy/pages/TabBarScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeScreen();
}

class PopMenuEx extends StatefulWidget
{
  const PopMenuEx({Key? key}):super(key: key);
  @override
  State<PopMenuEx> createState() => PopMenuItemsEx();
}

class _HomeScreen extends State<Home> {

  int _pos = 0;

  void _onMenuItemClick(int index){
    setState(() {
      _pos = index;
    });
  }

  @override
  Widget build(BuildContext con) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Chat Hub", style: TextStyle(fontSize: 20)),
          actions: const [
            PopMenuEx()
          ],
        ),
        body: Center(
          child: (_pos == 0)? const TabBarDesign() : (
            (_pos == 1)? const About() : (
              (_pos == 2)? const Setting() : const Help()
            )
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text("Chat Hub...", style: TextStyle(fontSize: 30),),
              ),
              ListTile(
                title: const Text("Home"),
                selected: _pos == 0,
                onTap: () {
                  _onMenuItemClick(0);
                },
              ),
              ListTile(
                title: const Text("About"),
                selected: _pos == 1,
                onTap: () {
                  _onMenuItemClick(1);
                },
              ),
              ListTile(
                title: const Text("Settings"),
                selected: _pos == 2,
                onTap: () {
                  _onMenuItemClick(2);
                },
              ),
              ListTile(
                title: const Text("Help"),
                selected: _pos == 3,
                onTap: () {
                  _onMenuItemClick(3);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PopMenuItemsEx extends State<PopMenuEx>
{
  void logout()
  async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove("email");
    sp.remove("pass");

    if(sp.getString("email") == null && sp.getString("pass") == null)
    {
      print("${sp.getString("email")} and ${sp.getString("pass")}");
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => const Login(),)
      );
    }

  }
  
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) =>
        [
          const PopupMenuItem(
            value: 1,
            child: Text("Logout"),
          ),
        ],
        elevation: 4,
        offset:  const Offset(10, 0),
        onSelected: (value) {
          if (value == 1)
          {
            Navigator.push(context,
              DialogRoute(context: context,
                builder:(context) {
                  return AlertDialog(
                    title: const Text("Logout"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Are you confirm for logout so press here!!!!"),
                        ElevatedButton(
                          onPressed: () {
                            logout();
                          },
                          child: Text("Yes")
                        )
                      ],
                    )
                  );
                },
              ),
            );
          }
        },
    );
  }
}