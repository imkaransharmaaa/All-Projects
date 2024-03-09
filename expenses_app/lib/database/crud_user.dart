import 'package:expenses_app/database/DBHelper.dart';
import 'package:expenses_app/model/User.dart';
import 'package:flutter/material.dart';

class CRUDUser
{
  static Future<void> addUsers(User user)
  async {
    String sql = "INSERT INTO ${DBHelper.USER_TABLE}(name, email, password, mobile) VALUES ('${user.name}', '${user.email}', '${user.password}', '${user.mobile}')";
    DBHelper.db.execute(sql);
  }
  static Future<User> checkLoginData(String email, String password, cont) async
  {
    String sql = "SELECT * FROM ${DBHelper.USER_TABLE} WHERE email = '$email' AND password = '$password' ";
    //await DBHelper.db.execute(sql);
    var res = await DBHelper.db.rawQuery(sql);

    if(res.isEmpty)
    {
      ScaffoldMessenger.of(cont).showSnackBar(const SnackBar(content: Text("Email and password is not registered !!", style: TextStyle(fontSize: 18)), backgroundColor: Color.fromARGB(255, 205, 115, 108),));
    }

    Map<String, dynamic>? item;

    res.forEach((element) {
      item = element.cast<String, dynamic>();
    });

    return User.fromData(item!);
  }
  static void updateUser()
  {
    
  }
  static void deleteUser()
  {
    
  }
  static showUser()
  {
    
  }
}