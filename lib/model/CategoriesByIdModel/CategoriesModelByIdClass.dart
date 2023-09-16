import 'package:new_projecct/model/CategoriesByIdModel/Categories.dart';
import 'package:new_projecct/model/CategoriesByIdModel/Dimensions.dart';
import 'package:new_projecct/model/CategoriesByIdModel/Images.dart';
import 'package:new_projecct/model/CategoriesByIdModel/Links.dart';

class CategoriesByIdModelClass {
  int? id;
  String? name;
  String? price;
  var image;
  CategoriesByIdModelClass({this.id, this.name, this.price, this.image});
  CategoriesByIdModelClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}