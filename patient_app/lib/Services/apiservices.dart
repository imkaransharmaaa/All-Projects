// ignore_for_file: unnecessary_null_comparison, unnecessary_brace_in_string_interps, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:patient_app/Models/Patients.dart';
import 'package:patient_app/Models/patientsList.dart';
import 'package:patient_app/Models/update_patients.dart';

class APIServices
{
  Future<PatientsResponse> addPatient(Patients patientData, var con)
  async{
    var url = Uri.parse("https://todearhemant.pythonanywhere.com/patient/api/patients/");
    var res;

    await http.post(url, body: jsonEncode(patientData.toJson()), headers: {
      "Content-Type" : "application/json"
    }).then((value) {
      res = value.body;
    });

    Map<String, dynamic> decode = json.decode(res);

    if(decode["id"] != null )
    {
      ScaffoldMessenger.of(con).showSnackBar(const SnackBar(content: Text("Data added successfully..."), backgroundColor: Colors.green, elevation: 0,));
      return PatientsResponse.fromJson(decode);
    }
    else
    {
      throw Exception();
    }
  }

  // Get api

  Future<List<PatientsList>> getPatient() async {

    List<PatientsList> patientsList = [];
    
    final response = await http.get(Uri.parse('https://todearhemant.pythonanywhere.com/patient/api/patients/'),headers: {
      "Content-Type" : "application/json"
    });
    final data = jsonDecode(response.body) as List;

    if(response.statusCode == 200)
    {
      for(Map<String, dynamic> index in data)
      {
        patientsList.add(PatientsList.fromJson(index));
      }
      return patientsList;
    }
    else{
      throw Exception();
    }
  }
  
  Future<UpdatePatient> updatePatient(UpdatePatient patientData, var con)
  async{
    var url = Uri.parse("https://todearhemant.pythonanywhere.com/patient/api/patients/${patientData.id}/");
    var res;
    await http.put(url, body: jsonEncode(patientData.updateJson()), headers: {
      "Content-Type" : "application/json"
    }).then((value) {
      res = value.body;
    });

    print("Res is => ${res}");

    Map<String, dynamic> decode = json.decode(res);

    if(res != null)
    {
      ScaffoldMessenger.of(con).showSnackBar(const SnackBar(content: Text("Data update successfully..."), backgroundColor: Colors.green, elevation: 0,));
      return UpdatePatient.fromJson(decode);
    }
    else
    {
      ScaffoldMessenger.of(con).showSnackBar(const SnackBar(content: Text("Data not update..."), backgroundColor: Colors.red,));
      throw Exception("byeee..........");
    }
  }

  Future<void> deletePatients(int id, var con)
  async{
    var url = Uri.parse("https://todearhemant.pythonanywhere.com/patient/api/patients/$id/");
    final response = await http.delete(url);

    print(response.body);

    if(response.statusCode == 204)
    {
      ScaffoldMessenger.of(con).showSnackBar(const SnackBar(content: Text("Data deleted successfully..."), backgroundColor: Colors.green, elevation: 0,));
    }
    else
    {
      ScaffoldMessenger.of(con).showSnackBar(const SnackBar(content: Text("Data not deleted..."), backgroundColor: Colors.red,));
    }
  }
}