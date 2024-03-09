
import 'package:shared_preferences/shared_preferences.dart';

class LoginRequest
{
  String ?email;
  String ?pass;

  LoginRequest(String? email,String? password)
  {
    this.email = email;
    this.pass = password;
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {
      'email': email?.trim(),
      'password': pass?.trim(),
    };

    return map;
  }
}
class LoginResponse
{
  final String? token;
  final bool? status;

  void saveData()
  async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("token", token!);
    print("Token is saved......");
  }

  LoginResponse({this.token,this.status});

  factory LoginResponse.fromJson(Map<String, dynamic> json) 
  {
    return LoginResponse(
      token: json["token"] != null ? json["token"] : "",
    );
  }
}