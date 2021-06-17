import 'package:nevis/database_model/moor_db.dart';

class CategoryModel {
  int id;
  String name;

  CategoryModel({
    this.id,
    this.name,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
  }

  CategoryModel.fromMoor(Categorie categorie) {
    this.id = categorie.id;
    this.name = categorie.name;
  }

  Categorie toMoor() => Categorie(id: this.id, name: this.name);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map<String, dynamic>();
    json["id"] = this.id.toString();
    json["name"] = this.name;

    return json;
  }
}
