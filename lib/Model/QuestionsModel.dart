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
        answersModel: AnswersModel.fromJsonArray(json['AnswersModel'])
    );
  }
  static fromJsonArray(List json) {
    return json.map((i)=>QuestionsModel.fromJson(i)).toList();
  }
}

