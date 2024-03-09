// ignore_for_file: file_names

class Patients 
{
  final String name;
  final String age;
  final String gender;

  Patients({required this.name, required this.age, required this.gender});

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {
      "name" : name.trim(),
      "age" : age.trim(),
      "gender" : gender.trim()
    };

    return map;
  }
}

class PatientsResponse
{
  final int id;
  final String name;
  final String age;
  final String gender;

  PatientsResponse({required this.id, required this.name, required this.age, required this.gender});

  factory PatientsResponse.fromJson(json)
  {
    return PatientsResponse(
      id: json["id"],
      name: json["name"],
      age: json["age"].toString(),
      gender: json["gender"]
    );
  }
}