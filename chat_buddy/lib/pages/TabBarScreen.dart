import 'package:chat_buddy/pages/UserList.dart';
import 'package:flutter/material.dart';

class TabBarDesign extends StatefulWidget
{
  const TabBarDesign({Key? key}) : super(key: key);
  @override
  State<TabBarDesign> createState() => _TabBarScreen();
}

class _TabBarScreen extends State<TabBarDesign>
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const TabBar(
                tabs: [
                  Tab(
                    text: "User List",
                  ),
                  Tab(
                    text: "User Chat",
                  ),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                Center(
                    child: UserListScreen()
                  ),
                Center(
                  child: Text("User Chat", style: TextStyle(fontSize: 25)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}