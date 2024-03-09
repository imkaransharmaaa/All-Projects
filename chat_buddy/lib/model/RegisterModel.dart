class RegisterRequest
{
  String? name;
  String? email;
  String? password;
  String? phone;
  String? gender;

  RegisterRequest(String? name,String? email,String? password,String? mobile,String? gender)
  {
    this.name = name;
    this.email = email;
    this.password = password;
    this.phone = mobile;
    this.gender = gender;
  }

  Map<String, dynamic> toJson()
  {
    Map<String, dynamic> regMap = {
      "name" : name?.trim(),
      "phone" : phone?.trim(),
      "email" : email?.trim(),
      "password" : password?.trim(),
      "gender" : gender?.trim() 
    };
    return regMap;
  }
}
class RegisterResponse
{
  final String ?message;
  final bool ? status;

  RegisterResponse({this.message,this.status});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) 
  {
    return RegisterResponse(
      message: json["message"] != null ? json["message"] : "",
      status : json["status"] != null ? json["status"] : "",
     );
  }
}