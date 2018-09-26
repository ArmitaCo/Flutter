import 'dart:convert';

import 'package:flutter_app_rote/Authentication.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app_rote/CategoryPage.dart';
import 'package:flutter_app_rote/CategoryModel.dart';

class PackageModel {
  final int id;
  final int categoryId;
  final String title;
  final String imageUrl;
  final String coverUrl;
  final String description;

  PackageModel({
    this.categoryId,
    this.coverUrl,
    this.description,
    this.id,
    this.imageUrl,
    this.title,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      title: json['Title'],
      categoryId: json['CategoryId'],
      coverUrl: json['CoverUrl'],
      description: json['Description'],
      id: json['Id'],
      imageUrl: json['ImageUrl'],
    );
  }

  static fromJsonArray(List json) {
    return json.map((i) => PackageModel.fromJson(i)).toList();
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
