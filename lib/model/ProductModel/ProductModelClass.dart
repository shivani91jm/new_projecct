import 'package:flutter/material.dart';

class CartModelClass{
late final int? id;
  final String? productId;
 final String? productName;
 final String? productDetails;
 final double? initilPrice;
 final double? productPrice;
 final ValueNotifier<int>? quantity;
 final String? image;

CartModelClass({
  required this.id,
  required this.productId,
  required this.productName,
  required this.productDetails,
  required this.initilPrice,
  required this.productPrice,
  required this.quantity,
  required this.image
});
CartModelClass.fromJson(Map<dynamic, dynamic> json) :
    id=json['id'],
     productId=json['productId'],
     productName=json['productName'],
      productDetails=json['productDetails'],
      initilPrice=json['initilPrice'],
      productPrice=json['productPrice'],
      quantity = ValueNotifier(json['qunatity']),
      image=json['image'];

Map<String, dynamic> toMap() {
  return {
    'id': this.id,
    'productId': this.productId,
    'productName': this.productName,
    'productDetails': this.productDetails,
    'initilPrice': this.initilPrice,
    'productPrice': this.productPrice,
    'qunatity': quantity?.value,
    'image': this.image
  };
}





}