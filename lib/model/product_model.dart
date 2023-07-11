import 'package:flutter/material.dart';
import 'package:shopo/model/category_model.dart';

class ProductModel with ChangeNotifier {
  int? id;
  String? title;
  int? price;
  String? description;
  List<String>? images;
  String? creationAt;
  String? updatedAt;
  CategoryModel? category;

  ProductModel(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.images,
      this.creationAt,
      this.updatedAt,
      this.category});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    images = json['images'].cast<String>();
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
    category = json['category'] != null
        ? CategoryModel.fromJson(json['category'])
        : null;
  }

  static List<ProductModel> productsFromSnapshot(List productsList) {
    return productsList.map((data) {
      return ProductModel.fromJson(data);
    }).toList();
  }
}
