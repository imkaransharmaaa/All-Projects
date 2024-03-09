class Category {
  int? id;
  String? catName;

  Category({required catName, required id});

  factory Category.fromData(Map<String, dynamic> data){
    return Category(
      id: data["id"],
      catName: data["cat_name"]
    );
  }
}