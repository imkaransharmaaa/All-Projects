// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patient_app/Models/Patients.dart';
import 'package:patient_app/Services/apiservices.dart';
import 'package:patient_app/pages/home_screen.dart';

class AddPatientsScreen extends StatefulWidget
{
  const AddPatientsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AddPatients();

}

class _AddPatients extends State<AddPatientsScreen>
{
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  String? gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          icon: Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height/1.4 ,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text("Add Patients", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text("Add new patients information", style: TextStyle(fontSize: 18, color: Colors.grey[700])),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.zero,
                      height: 200,
                      width: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/banner.png'),
                          fit: BoxFit.fill
                        )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: <Widget>[

                          TextFormField(
                            controller: name,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.zero
                              ),
                              labelText: "Name",
                            ),
                           keyboardType: TextInputType.name,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: age,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.zero
                              ),
                              labelText: "Age",
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                            autovalidateMode: AutovalidateMode.always,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.all(Radius.zero)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Text("Gender: ", style: TextStyle(fontSize: 18)),
                                ),
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text("Male", style: TextStyle(fontSize: 16)),
                                    Radio(
                                      value: "Male", 
                                      groupValue: gender, 
                                      onChanged: (value) {
                                        setState(() {
                                          gender = "Male";
                                        });
                                      },
                                    ),
                                  ]
                                ),
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text("Female", style: TextStyle(fontSize: 16)),
                                    Radio(
                                      value: "Female", 
                                      groupValue: gender, 
                                      onChanged: (value) {
                                        setState(() {
                                          gender = "Female";
                                        });
                                      },
                                    ),
                                  ]
                                ),
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text("Other", style: TextStyle(fontSize: 16)),
                                    Radio(
                                      value: "Other", 
                                      groupValue: gender, 
                                      onChanged: (value) {
                                        setState(() {
                                          gender = "Other";
                                        });
                                      },
                                    ),
                                  ]
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: MaterialButton(
                        minWidth: 200,
                        height: 40,
                        color: Color(0xff0095FF),
                        elevation: 0,
                        onPressed: () {
                          if(name.text.isNotEmpty && age.text.isNotEmpty && gender!.isNotEmpty){
                            APIServices api = APIServices();
                            api.addPatient(Patients(name: name.text, age: age.text, gender: gender!), context).then((value){
                              if(value.id != null)
                              {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                              }
                            });
                          }
                          else
                          {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter your details...."), elevation: 2, backgroundColor: Colors.red, behavior: SnackBarBehavior.fixed));
                          }
                        },
                        child: Text("Add Data", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget inputFile({label,controller, keyType})
  {
    return Column(
      children: [
        
      ],
    );
  }
}