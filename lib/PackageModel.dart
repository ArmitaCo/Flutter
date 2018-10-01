import 'dart:convert';
import 'dart:core';

import 'package:flutter_app_rote/Authentication.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';

class PackageModel {
  final int id;
  final int categoryId;
  final String title;
  final String imageUrl;
  final String coverUrl;
  final String description;
  final int userPackageId;
  final int userPackageState;

  PackageModel({
    this.categoryId,
    this.coverUrl,
    this.description,
    this.id,
    this.imageUrl,
    this.title,
    this.userPackageId,
    this.userPackageState
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      title: json['Title'],
      categoryId: json['CategoryId'],
      coverUrl: json['CoverUrl'],
      description: json['Description'],
      id: json['Id'],
      imageUrl: json['ImageUrl'],
      userPackageId: json['UserPackageId'],
      userPackageState:  json['UserPackageState'],
    );
  }

  static fromJsonArray(List json) {
    return json.map((i) => PackageModel.fromJson(i)).toList();
  }
Icon GetIcon (){
   int packageState = userPackageState;
   switch(packageState) {
     case 0:  return new Icon(Icons.sim_card);
     case 1: return new Icon(Icons.shopping_basket);
     case 2: return new Icon(Icons.check);
     case  3: return new Icon(Icons.check_circle);
     default: return new Icon(Icons.error);
   }

}

}

  Future<List<PackageModel>> GetPackages(BuildContext context, int Id) async {
   final header = await Authentication.getHeader(context);
  Map<String, String> x = {"id": Id.toString()};
   List<PackageModel> PackageData = new List<PackageModel>();
  final response =
  await http.post("http://31.25.130.239/api/packages/packages",body: x,headers: header);
  PackageData = PackageModel.fromJsonArray(
      json.decode(response.body)["Data"]["Result"]);
  return PackageData;
}
Future<List<PackageModel>> GetMyPackages(BuildContext context) async {
  final header = await Authentication.getHeader(context);
  List<PackageModel> MyPackageData = new List<PackageModel>();
  final response =
  await http.post("http://31.25.130.239/api/packages/mypackages2",headers: header);
  MyPackageData = PackageModel.fromJsonArray(
      json.decode(response.body)["Data"]["Result"]);
  return MyPackageData;
}

