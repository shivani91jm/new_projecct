import 'package:new_projecct/model/CategoriesByIdModel/CategoriesModelByIdClass.dart';

class Category {
  String? name;
  String? description;
  List<CategoriesByIdModelClass>? products;

  Category({this.name, this.description, this.products});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    if (json['products'] != null) {
      products = <CategoriesByIdModelClass>[];
      json['products'].forEach((v) {
        products!.add(new CategoriesByIdModelClass.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

