import 'dart:async';
import 'dart:convert';
import 'package:flutter_app_rote/Tools/ConstValues.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_rote/Tools/Authentication.dart';

import 'AnswersModel.dart';
class QuestionsModel {
  final int id;
  final String questionText;
  final int correctAnswer;
  final String answerText;
  final List<AnswersModel> answersModel;

  QuestionsModel({
    this.id,
    this.questionText,
    this.correctAnswer,
    this.answerText,
    this.answersModel
  });

  factory QuestionsModel.fromJson(Map<String, dynamic> json) {
    return QuestionsModel(
        id: json['Id'],
        questionText: json['QuestionText'],
        correctAnswer: json['CorrextAnswer'],
        answerText: json['AnswerText'],
        answersModel: AnswersModel.fromJsonArray(json['Answers'])
    );
  }
  static fromJsonArray(List json) {
    return json.map((i)=>QuestionsModel.fromJson(i)).toList();
  }
}
Future<List<QuestionsModel>> GetQuestions(BuildContext context,
    int userPackageBoxId) async
{
  final header = await Authentication.getHeader(context);
  Map<String, String> x = {"id": userPackageBoxId.toString()};
  List<QuestionsModel> questions = new List<QuestionsModel>();
  final response = await http.post(
      Values.Host+"api/boxes/UserBoxQuestions",
      body: x, headers: header);
  questions = QuestionsModel.fromJsonArray(
      json.decode(response.body)["Data"]["Result"]);
  return questions;
}
