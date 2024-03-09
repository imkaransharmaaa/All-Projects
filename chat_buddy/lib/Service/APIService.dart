import 'dart:convert';
import 'package:chat_buddy/model/LoginModel.dart';
import 'package:chat_buddy/model/RegisterModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class APIService
{
  Future<LoginResponse> login(LoginRequest requestModel) async {
    String url = "http://apps.codebetter.in:8082/chatbuddy/auth/login";

    final response = await http.post(Uri.parse(url), body: requestModel.toJson());
   
    Map<String,dynamic> decodeData = json.decode(response.body);

    if(decodeData["status"] == true)
    {
      return LoginResponse.fromJson(decodeData["data"]);
    }
    else{
      throw Exception("Failed to load Data....");
    }
  }


  Future<RegisterResponse> register(RegisterRequest requestModel) async{
    String url = "http://apps.codebetter.in:8082/chatbuddy/auth/save";

    final response = await http.post(Uri.parse(url),body: requestModel.toJson());
    Map<String,dynamic> decodeData = json.decode(response.body);

    if(decodeData["status"] == true)
    {
      return RegisterResponse.fromJson(decodeData);
    }
    else
   {
    throw Exception("Register Failed.....");
   }
  }

  Future userInfo() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? spToken = sp.getString("token");
    
    String url = "http://apps.codebetter.in:8082/chatbuddy/api/user/list";
    //print(spToken);

    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $spToken',
    });
    Map<String,dynamic> decodeData = json.decode(response.body);
    //print(decodeData["data"]);

    sp.setStringList("users", decodeData["data"]);

    if(decodeData["status"] == true)
    {
      return decodeData["data"];
    }
    else
   {
    throw Exception("Register Failed.....");
   }
  }
}