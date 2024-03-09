
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patient_app/Models/patientsList.dart';
import 'package:patient_app/Models/update_patients.dart';
import 'package:patient_app/Services/apiservices.dart';
import 'package:patient_app/pages/add_patients.dart';

class HomeScreen extends StatefulWidget
{
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => Home();
}

class Home extends State<HomeScreen>
{
  List<PatientsList> patientsList = [];

  Future<void> refreshData()
  async{
    APIServices api = APIServices();
    await api.getPatient().then((value) {
      setState(() {
        patientsList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    refreshData();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Patient"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddPatientsScreen()));
              },
              icon: Icon(Icons.add, size: 32),
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: refreshData,
          child: ListView.builder(
            itemCount: patientsList.length,
            itemBuilder: (
            context, index) 
            {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Card(
                  elevation: 8,
                  child: ListTile(
                    title: Text(patientsList[index].name, style: TextStyle(fontSize: 15)),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>patientDetails(index)));
                    },
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        if(value == 'update'){
                          updateData(patientsList[index].id);
                        }
                        else if(value == 'delete')
                        {
                          deleteData(patientsList[index].id, context);
                        }
                      },
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            value: 'update',
                            child: Text("Update Data"),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Text("Delete Data"),
                          ),
                        ];
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        )
    );
  }

  void deleteData(int id, cont)
  {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("If you wanna delete data"),
          actions: [
            MaterialButton(
              onPressed: () {
                APIServices api = APIServices();
                api.deletePatients(id, cont).whenComplete((){
                  Navigator.pop(context);
                });
              },
              child: Text("Yes"),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("No"),
            )
          ],
        );
      },
    );
  }

  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  String? gender;  

  void updateData(int id)
  {
    if(id != null){
      final existingData = patientsList.firstWhere((element) => element.id == id);
      setState(() {
        name.text = existingData.name;
        age.text = existingData.age;
        gender = existingData.gender;
      });
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update Patient Details"),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: TextFormField(
                  controller: name,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "Patient Name"
                  ),
                  
                )
              ),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: TextField(
                  controller: age,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "Patient Age"
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                )
              ),
              Container(
                padding: EdgeInsets.zero,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Gender :", style: TextStyle(fontSize: 15)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.start,
                          children: [
                            Text("Male"),
                            Radio<String>(
                              value: "Male",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value;
                                });
                              },
                            ),
                          ]
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.start,
                          children: [
                            Text("Female"),
                            Radio<String>(
                              value: "Female",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value;
                                });
                              },
                            ),
                          ]
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.start,
                          children: [
                            Text("Other"),
                            Radio<String>(
                              value: "Other",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value;
                                });
                              },
                            ),
                          ]
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ]
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 12),
          actions: [
            TextButton(
              child: Text("Update Data"),
              onPressed: () {
                if (name.text.isNotEmpty && age.text.isNotEmpty && gender != null) {
                  APIServices api = APIServices();
                  api.updatePatient(UpdatePatient(id: id, name: name.text, age: age.text, gender: gender!), context).then((value) {
                    if(value.id != null)
                    {
                      Navigator.pop(context);
                    }
                  });
                }
                else
                {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("If your are update data so enter data", style: TextStyle(fontSize: 15)), backgroundColor: Colors.amber[900],));
                  Navigator.pop(context);
                }
              },
            )
          ],
        );
      },
    );
  }

  patientDetails(int pos)
  {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Table(
            children: [
              TableRow(
                children: [
                  Text("Id", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
                  Text(patientsList[pos].id.toString(), style: TextStyle(fontSize: 28)),
                ]
              ),
              TableRow(
                children: [
                  Text("Name", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
                  Text(patientsList[pos].name, style: TextStyle(fontSize: 28)),
                ]
              ),
              TableRow(
                children: [
                  Text("Age", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
                  Text(patientsList[pos].age, style: TextStyle(fontSize: 28)),
                ]
              ),
              TableRow(
                children: [
                  Text("Gender", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
                  Text(patientsList[pos].gender, style: TextStyle(fontSize: 28)),
                ]
              ),
            ],
          ),
        )
      ),
    );
  }
}