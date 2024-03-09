class Expense
{
  int ? eid;
  String? expName;
  String? expCategory;
  String? expDesc;
  String? expDate;
  int? expPrice;

  Expense({this.expName,this.expDesc,this.expCategory,this.expDate,this.expPrice, this.eid});

  Map<String, dynamic> toData()
  {
    Map<String, dynamic> item = {
      'title': expName,
      'description': expDesc,
      'category': expCategory,
      'date': expDate,
      'price': expPrice,
    };
    return item;
  }

  factory Expense.fromData(Map<String, dynamic> data)
  {
    return Expense(
      eid: (data["id"] != null) ? data["id"] : "",
      expName: (data["title"] != null) ? data["title"] : "",
      expDesc: (data["description"] != null) ? data["description"] : "",
      expCategory: (data["category"] != null) ? data["category"] : "",
      expDate: (data["date"] != null) ? data["date"] : "",
      expPrice: (data["price"] != null) ? data["price"] : ""
    );
  }

}