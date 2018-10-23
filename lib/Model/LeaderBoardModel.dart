import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Model/ChallengeModel.dart';
import 'package:flutter_app_rote/Model/LeaderBoardItemModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app_rote/Tools/Authentication.dart';
import 'package:flutter_app_rote/Tools/ConstValues.dart';

class LeaderBoardModel {
  LeaderBoardItem userItem;
  ChallengeModel challenge;
  List<LeaderBoardItem> leaderBoardItems;

  LeaderBoardModel({this.leaderBoardItems, this.challenge, this.userItem});

  factory LeaderBoardModel.fromJson(Map<String, dynamic> json) {
    LeaderBoardItem userItem = json['UserItem'] == null
        ? null
        : LeaderBoardItem.fromJson(json['UserItem']);

    return LeaderBoardModel(
        userItem: userItem,
        challenge: ChallengeModel.fromJson(json['Challenge']),
        leaderBoardItems: LeaderBoardItem.fromJsonArray(json['Items']));
  }


}

Future<LeaderBoardModel> getLeaderBoard(BuildContext context) async {
  final header = await Authentication.getHeader(context);
  final response =
      await http.post(Values.Host + "api/profile/leaderboard", headers: header);

  LeaderBoardModel leaderBoard =
      LeaderBoardModel.fromJson(json.decode(response.body)["Data"]["Result"]);
  return leaderBoard;
}
