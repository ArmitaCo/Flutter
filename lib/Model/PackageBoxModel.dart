import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Tools/Authentication.dart';
import 'package:http/http.dart' as http;

class PackageBoxModel {
  final int id;
  final int userPackageId;
  final int packageId;
  final int code;
  final int boxState;
  final int stateValue;
  final String title;

  PackageBoxModel({
    this.id,
    this.userPackageId,
    this.packageId,
    this.code,
    this.boxState,
    this.stateValue,
    this.title,
  });

  factory PackageBoxModel.fromJson(Map<String, dynamic> json) {
    return PackageBoxModel(
      title: json['Title'],
      stateValue: json['StateValue'],
      boxState: json['BoxState'],
      code: json['Code'],
      packageId: json['PackageId'],
      userPackageId: json['UserPackageBoxId'],
      id: json['Id'],
    );
  }

  static fromJsonArray(List json) {
    return json.map((i) => PackageBoxModel.fromJson(i)).toList();
  }

  Icon GetBoxIcon() {
    int boxStateIcon = boxState;
    switch (boxStateIcon) {
      case 0:
        return new Icon(Icons.not_interested);
      case 1:
        return new Icon(Icons.cloud_upload);
      case 2:
        return new Icon(Icons.done);
      case 3:
        return new Icon(Icons.done_all);
    }
  }
}

Future<List<PackageBoxModel>> GetPackageBox(BuildContext context, int Id) async {
  final header = await Authentication.getHeader(context);
  Map<String, String> x = {"id": Id.toString()};
  List<PackageBoxModel> PackageBoxData = new List<PackageBoxModel>();
  final response = await http.post("http://31.25.130.239/api/packages/UserPackageBoxes",
      body: x, headers: header);
  PackageBoxData = PackageBoxModel.fromJsonArray(
      json.decode(response.body)["Data"]["Result"]);
  return PackageBoxData;
}


