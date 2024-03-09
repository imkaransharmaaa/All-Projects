class UpdatePatient {
    final int id;
    final String name;
    final String age;
    final String gender;

    UpdatePatient({
        required this.id,
        required this.name,
        required this.age,
        required this.gender,
    });
    
    Map<String, dynamic> updateJson() => {
        "name": name,
        "age": age,
        "gender": gender,
    };

    factory UpdatePatient.fromJson(Map<String, dynamic> json) => UpdatePatient(
        id: json["id"],
        name: json["name"],
        age: json["age"].toString(),
        gender: json["gender"],
    );    
}