class User
{
  int? uid;
  String? name;
  String? email;
  String? password;
  String? mobile;

  User({this.name, this.email, this.password, this.mobile,this.uid});

  Map<String, dynamic> toData()
  {
    Map<String, dynamic> item = {
      'name' : name,
      'email' : email,
      'password' : password,
      'mobile' : mobile,
    };
    return item;
  }

  factory User.fromData(Map<String, dynamic> data)
  {
    return User(
      uid: (data["id"] != null) ? data["id"] : "",
      name: (data["name"] != null) ? data["name"] : "",
      email: (data["email"] != null) ? data["email"] : "",
      password: (data["password"] != null) ? data["password"] : "",
      mobile: (data["mobile"] != null) ? data["mobile"] : "",
    );
  }

}
