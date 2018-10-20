import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Model/AvatarModel.dart';
import 'package:flutter_app_rote/Model/ExternalArticleModel.dart';
import 'package:flutter_app_rote/Tools/Authentication.dart';
import 'package:flutter_app_rote/Tools/ConstValues.dart';
import 'package:http/http.dart' as http;

//"FirstName": "a",
//"LastName": "b.c",
//"Mobile": "09363505697",
//"Email": "a@b.c",
//"AvatarImage": {
//"Id": 4,
//"Image": "http://mohsenmeshkini.ir/Images/Avatars/jorge.png"
//}

class ProfileModel {
  final int id;
  final String firstName;
  final String lastName;
  final String mobile;
  final String email;
  final AvatarModel avatar;

  ProfileModel(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.mobile,
      this.avatar});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        id: json['Id'],
        firstName: json['FirstName'],
        lastName: json['LastName'],
        mobile: json['Mobile'],
        email: json['Email'],
        avatar: AvatarModel.fromJson(json['AvatarImage']));
  }
}


Future<ProfileModel> getProfileData(BuildContext context) async
{
  final header = await Authentication.getHeader(context);
  final response = await http.post(
      Values.Host+"api/Profile/ProfileData",
      headers: header);
  ProfileModel model = ProfileModel.fromJson(json.decode(response.body)["Data"]["Result"]);
  return model;
}