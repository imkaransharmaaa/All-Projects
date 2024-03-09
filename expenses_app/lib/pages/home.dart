// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:expenses_app/pages/add_expenses.dart';
import 'package:expenses_app/pages/show_expenses.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget
{
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => _Home();
  
}

class _Home extends State<HomeScreen>
{
  int _pos = 0;

  void _onMenuClick(int index)
  {
    setState(() {
      _pos = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Expenses"),
          actions: [
            PopupMenu()
          ],
        ),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              DrawerHeader(decoration: BoxDecoration(color: Colors.blue),padding: EdgeInsets.symmetric(vertical: 40, horizontal: 44), child: Text("Day to Day Expense App", style: TextStyle(fontSize: 20))),
              ListTile(
                title: const Text("Show Expenses"),
                selected: _pos == 0,
                onTap: () {
                  _onMenuClick(0);
                },
              ),
              ListTile(
                title: const Text("Add Expenses"),
                selected: _pos == 1,
                onTap: () {
                  _onMenuClick(1);
                },
              ),
              ListTile(
                title: const Text("Monthly Report"),
                selected: _pos == 2,
                onTap: () {
                  _onMenuClick(2);
                },
              ),
              ListTile(
                title: const Text("Chart"),
                selected: _pos == 3,
                onTap: () {
                  _onMenuClick(3);
                },
              ),
              ListTile(
                title: const Text("Upload Bill"),
                selected: _pos == 4,
                onTap: () {
                  _onMenuClick(4);
                },
              )
            ],
          ),
        ),
        body: (_pos == 0)? const ShowExpensesScreen() : ((_pos == 1)? const AddExpensesScreen(): Container()),
      ),
    );
  }

  Widget PopupMenu()
  {
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
            Navigator.pop(context);
          }
        },
    );
  }
}