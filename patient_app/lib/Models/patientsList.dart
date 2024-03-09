// ignore_for_file: file_names

import 'dart:convert';

List<PatientsList> patientFromJson(String str) => List<PatientsList>.from(json.decode(str).map((x) => PatientsList.fromJson(x)));

String patientToJson(List<PatientsList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PatientsList {
    final int id;
    final String name;
    final String age;
    final String gender;

    PatientsList({
        required this.id,
        required this.name,
        required this.age,
        required this.gender,
    });

    factory PatientsList.fromJson(Map<String, dynamic> json) => PatientsList(
        id: json["id"],
        name: json["name"],
        age: json["age"].toString(),
        gender: json["gender"],
    );

    Map<String, dynamic> toJson() => {
      //  "id": id,
        "name": name,
        "age": age,
        "gender": gender,
    };
}
