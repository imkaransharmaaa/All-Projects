// ignore_for_file: constant_identifier_names, depend_on_referenced_packages, file_names

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper
{
   static const String _databaseName = "myexpense.db";
   static const int _version = 1;

   static const String USER_TABLE = "user";
   static const String EXPENSE_TABLE = "expense";
   static const String CATEGORY_TABLE = "category";
   static late Database db;

   Future<void>init() async{
       final documentsDirectory = await getApplicationDocumentsDirectory();
       print("Directory : $documentsDirectory");

       final path = join(documentsDirectory.path, _databaseName);
       print("Path is : $path"); 

      db = await openDatabase(path, version: _version, onCreate: _onCreate,);
       print("DB is : $db");
   }

   Future _onCreate(Database db, int version) async
   {
    String? sql = "CREATE TABLE $USER_TABLE(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, email TEXT NOT NULL UNIQUE, password TEXT NOT NULL, mobile TEXT UNIQUE)";
    await db.execute(sql);

    String? expSQL = "CREATE TABLE $EXPENSE_TABLE(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT NOT NULL,description TEXT,category TEXT,date TEXT,price int)";
    await db.execute(expSQL);

    String? catSQL = "CREATE TABLE $CATEGORY_TABLE(id INTEGER PRIMARY KEY AUTOINCREMENT,cat_name TEXT NOT NULL)";
    await db.execute(catSQL);

    String? catData = "INSERT INTO $CATEGORY_TABLE(cat_name) VALUES('Food'),('Drinks'),('Transport'),('Vehicle'),('Entertainment')";
    await db.execute(catData);
   }
}