// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously, unnecessary_null_comparison

import 'package:expenses_app/database/crud_expenses.dart';
import 'package:expenses_app/model/Expense.dart';
import 'package:flutter/material.dart';

class ShowExpensesScreen extends StatefulWidget
{
  const ShowExpensesScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShowExpenses();
}

class _ShowExpenses extends State<ShowExpensesScreen>
{
  List<Map<String, dynamic>>? expensesList;

  void dataShow()
  async{
    await CRUDExpenses.showExpensesList().then((value){
      setState(() {
        expensesList = value;
      });
    });
  }
  
  @override
  Widget build(BuildContext context){
    dataShow();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView.builder(
          itemCount: expensesList!.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(expensesList![index]["title"]),
                trailing: Text("₹ ${expensesList![index]["price"]}"),
                onTap: () {
                  expenseDetails(expensesList![index]["id"], index);
                },
              ),
            );
          },
        ),
      ),
    );
  }
  void expenseDetails(int id, index)
  async{
    late Expense exData;
    await CRUDExpenses.showExpense(id).then((value) {
      setState(() {
        exData = value;
      });
    });
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(exData.expName!, style: TextStyle(fontSize: 25)),
              Text("₹${exData.expPrice!}", style: TextStyle(fontSize: 25)),
            ],
          ),
          content: ListTile(
            title: Text(exData.expDesc!, style: TextStyle(fontSize: 22)),
            subtitle: Row(
              children: <Widget>[
                Text(exData.expCategory!, style: TextStyle(fontSize: 18)),
                SizedBox(width: 20),
                Text(exData.expDate!, style: TextStyle(fontSize: 18))
              ],
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                deleteExpense(id).whenComplete((){
                  Navigator.pop(context);
                });
              },
              child: Text("Delete"),
            ),
            MaterialButton(
              onPressed: () {
                updateExpense(id, index).whenComplete((){
                  Navigator.pop(context);
                });
              },
              child: Text("Edit"),
            )
          ],
        );
      },
    );
  }

  Future<void> deleteExpense(int id)
  async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Are you want to delete data?"),
          actions: [
            MaterialButton(
              onPressed: () {
                CRUDExpenses.deleteExpenses(id).whenComplete(() {
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
      }
    );
  }

  //Update field controller and variables
  TextEditingController upTitle = TextEditingController();
  TextEditingController upDesc = TextEditingController();
  TextEditingController upPrice = TextEditingController();
  String? upCategory;
  String? upDate;
  late List<String> upCategoryList;

  Future<void> datePicker()
  async {
    final DateTime now = DateTime.now();
    showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2550)
    ).then((DateTime? value){
      setState(() {
        upDate = (value!.day < 10) ? ((value.month < 10)?  "0${value.day}-0${value.month}-${value.year}" : "0${value.day}-${value.month}-${value.year}") : ((value.month < 10) ? "${value.day}-0${value.month}-${value.year}" : "${value.day}-${value.month}-${value.year}");
      });
    });
  }

  Future<void> updateExpense(int id, index)
  async {
    await CRUDExpenses.showCategory().then((value) {
      setState(() {
        upCategoryList = value;
      });
    });

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update Data"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextFormField(
                    controller: upTitle,
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
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextField(
                    controller: upDesc,
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
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: upPrice,
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
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey)  
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text("Please Select Category", style: TextStyle(color: Color.fromARGB(255, 127, 127, 127))),
                      value: upCategory,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 40,
                      elevation: 2,
                      items: upCategoryList.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          upCategory = value!;
                        });
                      },
                    ),
                  )
                ),
                Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width/1,
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey)  
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (upDate != null)? Text(upDate!, style: TextStyle(fontSize: 17)) : const Text("DD-MM-YYYY", style: TextStyle(fontSize: 17, color: Color.fromARGB(255, 127, 127, 127))),
                      IconButton(onPressed: () => datePicker(), icon: const Icon(Icons.event, color: Colors.blue, size: 30))
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                CRUDExpenses.updateExpenses(Expense(eid: id, expName: upTitle.text, expDesc: upDesc.text, expCategory: upCategory, expDate: upDate, expPrice: int.parse(upPrice.text))).whenComplete(() {
                  Navigator.pop(context);
                });
              },
              child: Text("Update Data"),
            ),
          ],
        );
      }
    );
  }

}