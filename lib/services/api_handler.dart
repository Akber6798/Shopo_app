// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:shopo/const/api_const.dart';
import 'package:shopo/model/category_model.dart';
import 'package:shopo/model/product_model.dart';
import 'package:shopo/model/user_model.dart';
import 'package:shopo/screens/error_screen.dart';

class ApiHandler {
  
  //common function for get all products and categories
  static Future<List<dynamic>> getData(
      {required String target,
      required BuildContext context,
      String? limit}) async {
    try {
      var uri = Uri.https(BASE_URL, "api/v1/$target",
          target == "products" ? {"offset": "0", "limit": limit} : {});
      var response = await http.get(uri);
      var data = jsonDecode(response.body);
      List tempList = [];
      if (response.statusCode != 200) {
        throw data["message"];
      }
      for (var details in data) {
        tempList.add(details);
      }
      return tempList;
    } catch (error) {
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const ErrorScreen(),
        ),
      );
      throw error.toString();
    }
  }

  //get all products
  static Future<List<ProductModel>> getAllProducts(
      {required BuildContext context, required String limit}) async {
    List temp =
        await getData(target: "products", context: context, limit: limit);
    return ProductModel.productsFromSnapshot(temp);
  }

  //get Categories
  static Future<List<CategoryModel>> getAllCategories(
      BuildContext context) async {
    List temp = await getData(target: "categories", context: context);
    return CategoryModel.categoryFromSnapshot(temp);
  }

  //get all users
  static Future<List<UserModel>> getAllUsers(BuildContext context) async {
    List temp = await getData(target: "users", context: context);
    return UserModel.usersFromSnapshot(temp);
  }

  //get singleproduct with id
  static Future<ProductModel> getProductById(
      {required String id, required BuildContext context}) async {
    try {
      var uri = Uri.https(BASE_URL, "api/v1/products/$id");
      var response = await http.get(uri);
      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw data["message"];
      }
      return ProductModel.fromJson(data);
    } catch (error) {
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const ErrorScreen(),
        ),
      );
      throw error.toString();
    }
  }
}
