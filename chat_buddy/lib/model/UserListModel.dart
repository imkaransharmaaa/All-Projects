class User
{
  final String name;
  final String phone;

  User({required this.name, required this.phone});

  factory User.fromJson(data) 
  {
    return User(
      name: data["name"],
      phone: data["phone"]
    );
  }
}