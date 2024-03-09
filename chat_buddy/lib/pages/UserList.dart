import 'package:chat_buddy/Service/APIService.dart';
import 'package:chat_buddy/model/UserListModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  APIService api = APIService();

  late List<String> data;
  
  @override
  void initState() {
    super.initState();
    api.userInfo();    
  }

  void getUsers() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    data = sp.getStringList("users")!;
  }
  

  //List<User>? users = data.cast<User>();// = usersData();
 /* List<User> usersData()
  {
    var data = decodeData["data"];   
    return data.map<User>(User.fromJson).toList();
  }*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //body: buildUsers(users!),
      ),
    );
  }

  Widget buildUsers(List<User> users) => ListView.builder(
    itemCount: users.length,
    itemBuilder: (context, index) {
      final user = users[index];

      return Card(
        child: ListTile(
          leading: CircleAvatar(
            radius: 28,
            child: Icon(Icons.person),
          ),
          title: Text(user.name),
          subtitle: Text(user.phone),
        ),
      );
    },
  );

}
