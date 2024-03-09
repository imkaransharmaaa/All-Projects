// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, avoid_print, prefer_final_fields, unused_field, unnecessary_this

import 'package:expenses_app/database/crud_expenses.dart';
import 'package:expenses_app/model/Expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddExpensesScreen extends StatefulWidget
{
  const AddExpensesScreen({Key? key}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => _AddExpenses();
  
}
class _AddExpenses extends State<AddExpensesScreen>
{
  List<String> _categoryList = [];
  String? category;
  String? date;

  @override
  void initState() {
    super.initState();
    CRUDExpenses.showCategory().then((value) {
      setState(() {
        _categoryList = value;
      });
    });
  }
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController price = TextEditingController();

  Future<void> datePicker()
  async {
    final DateTime now = DateTime.now();
    showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050)
    ).then((DateTime? value){
      setState(() {
        date = (value!.day < 10) ? ((value.month < 10)?  "0${value.day}-0${value.month}-${value.year}" : "0${value.day}-${value.month}-${value.year}") : ((value.month < 10) ? "${value.day}-0${value.month}-${value.year}" : "${value.day}-${value.month}-${value.year}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 28),
                child: const Text("Add Expenses", style: TextStyle(fontSize: 25, color: Color.fromARGB(255, 2, 64, 106))),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: TextField(
                  controller: title,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    labelText: "Title",
                    labelStyle: TextStyle(color: Color.fromARGB(255, 127, 127, 127))
                  ),
                )
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: TextField(
                  controller: desc,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    labelText: "Descripation",
                    labelStyle: TextStyle(color: Color.fromARGB(255, 127, 127, 127))
                  ),
                )
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: price,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    labelText: "Price",
                    labelStyle: TextStyle(color: Color.fromARGB(255, 127, 127, 127))
                  ),
                )
              ),
              Container(
                height: 55,
                width: MediaQuery.of(context).size.width/1,
                margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 13),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey)  
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Text("Please Select Category", style: TextStyle(color: Color.fromARGB(255, 127, 127, 127))),
                    value: category,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 40,
                    elevation: 2,
                    items: _categoryList.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        category = value!;
                      });
                    },
                  ),
                )
              ),
              Container(
                height: 55,
                width: MediaQuery.of(context).size.width/1,
                margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey)  
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (date != null)? Text(date!, style: TextStyle(fontSize: 17)) : const Text("DD-MM-YYYY", style: TextStyle(fontSize: 17, color: Color.fromARGB(255, 127, 127, 127))),
                    IconButton(onPressed: () => datePicker(), icon: const Icon(Icons.event, color: Colors.blue, size: 30))
                  ],
                ),
              ),
              Container(
                height: 40,
                width: 180,
                margin: const EdgeInsets.only(top: 30, bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    print(title.text);
                    print(desc.text);
                    print(price.text);
                    print(category);
                    print(date);
                    CRUDExpenses.addExpenses(Expense(expName: title.text, expDesc: desc.text, expCategory: category, expDate: date, expPrice: int.parse(price.text)));                 
                  },
                  child: const Text("Save", style: TextStyle(fontSize: 22),)
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}