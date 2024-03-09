
import 'package:expenses_app/database/DBHelper.dart';
import 'package:expenses_app/model/Expense.dart';
class CRUDExpenses
{
  static Future<void> addExpenses(Expense expense) async
  {
    //String insert = "INSERT INTO ${DBHelper.EXPENSE_TABLE}(title, description, category, date, price) VALUES (${expense.toData()})";
    //await DBHelper.db.execute(insert);
    await DBHelper.db.insert(DBHelper.EXPENSE_TABLE, expense.toData());
  }
  static Future<void> updateExpenses(Expense expense) async
  {
    //String upSql = "UPDATE ${DBHelper.EXPENSE_TABLE} SET (title, description, category, date, price) VALUES (${expense.toData()}) WHERE id = ${expense.eid}";
    //await DBHelper.db.execute(upSql);
    await DBHelper.db.update(DBHelper.EXPENSE_TABLE, expense.toData());
  }
  static Future<void> deleteExpenses(int id) async
  {
    await DBHelper.db.delete(DBHelper.EXPENSE_TABLE, where: 'id = $id');
  }
  static Future<Expense> showExpense(int id) async
  {
    //specific expense show
    //String spData = "SELECT * FROM ${DBHelper.EXPENSE_TABLE} WHERE id = $id";

    List<Map> res = await DBHelper.db.query(DBHelper.EXPENSE_TABLE, where: 'id = $id');

    print("object1 =>> $res");

    Map<String, dynamic>? item;

    res.forEach((element) {
      item = element.cast<String, dynamic>();
    });

    return Expense.fromData(item!);


  }
  static Future<List<Map<String, dynamic>>> showExpensesList() async
  {
    List<Map> res = await DBHelper.db.query(DBHelper.EXPENSE_TABLE);

    List<Map<String, dynamic>>? items = [];
    items = res.map((e) => e).cast<Map<String, dynamic>>().toList();
    return items;    
  }

  static Future<List<String>> showCategory() async
  {
    List<Map> res = await DBHelper.db.query(DBHelper.CATEGORY_TABLE);

    List<String>? items = [];
    items = res.map((e) => e["cat_name"]).cast<String>().toList();
    return items;    
  }

}