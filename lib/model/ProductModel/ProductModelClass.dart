import 'package:flutter/material.dart';

class CartModelClass{

  final String? productId;
 final String? productName;
 final String? productDetails;
 final double? initilPrice;
 final double? productPrice;
 late final int quantity;
 final String? image;

CartModelClass({

  required this.productId,
  required this.productName,
  required this.productDetails,
  required this.initilPrice,
  required this.productPrice,
  required this.quantity,
  required this.image
});
CartModelClass.fromJson(Map<dynamic, dynamic> json) :

     productId=json['productId'],
     productName=json['productName'],
      productDetails=json['productDetails'],
      initilPrice=json['initilPrice'],
      productPrice=json['productPrice'],
      quantity = json['qunatity'],
      image=json['image'];

Map<String, dynamic> toMap() {
  return {

    'productId': this.productId,
    'productName': this.productName,
    'productDetails': this.productDetails,
    'initilPrice': this.initilPrice,
    'productPrice': this.productPrice,
    'qunatity': quantity,
    'image': this.image
  };
}





}