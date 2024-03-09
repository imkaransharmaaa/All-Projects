import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget
{
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreen();
  
}

class PopMenuEx extends StatefulWidget
{
  const PopMenuEx({Key? key}):super(key: key);
  @override
  State<PopMenuEx> createState() => PopMenuItemsEx();
}

class _HomeScreen extends State<Home>
{
  int _pos = 0;

  void _onMenuItemClick(int index){
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
          title: const Text("ChatHub"),
          actions: const [
            PopMenuEx()
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.amber),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(child: Icon(Icons.person)),
                    Text("Name", style: TextStyle(fontSize: 20),)
                  ],
                ),
              ),
              ListTile(
                title: Text("Home"),
                selected: _pos == 0,
                onTap: () {
                  _onMenuItemClick(0);
                },
              ),
              ListTile(
                title: Text("User List"),
                selected: _pos == 1,
                onTap: () {
                  _onMenuItemClick(1);
                },
              ),
              ListTile(
                title: Text("Friends List"),
                selected: _pos == 2,
                onTap: () {
                  _onMenuItemClick(2);
                },
              ),
              ListTile(
                title: Text("Profile"),
                selected: _pos == 3,
                onTap: () {
                  _onMenuItemClick(3);
                },
              ),
              ListTile(
                title: Text("Self Post"),
                selected: _pos == 4,
                onTap: () {
                  _onMenuItemClick(4);
                },
              ),
              ListTile(
                title: Text("Logout"),
                selected: _pos == 5,
                onTap: () {
                  _onMenuItemClick(5);
                },
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("All Posts"),
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 40,
                            width: 100,
                            child: Icon(Icons.photo),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Title"), 
                              Text("Message"),
                              Text("Name")
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              
                            },
                            icon: const Icon(Icons.favorite)
                          ),
                          Container(
                            width: 200,
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                icon: IconButton(
                                  onPressed: () {
                                    
                                  },
                                  icon: const Icon(Icons.send)
                                )
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              
                            },
                            icon: const Icon(Icons.share)
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            )
          ],
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
      Navigator.pop(context);
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