import 'package:flutter_app_rote/Model/ExternalArticleModel.dart';

class ArticleModel {
  final int id;
  final String title;
  final String imageUrl;
  final String order;
  final List<ExternalArticleModel> externalArticles;

  ArticleModel({this.id,
    this.title,
    this.imageUrl,
    this.order,
    this.externalArticles
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title:  json['Title'],
      id:  json['Id'],
      imageUrl: json['ImageUrl'],
      order: json['Order'],
      externalArticles: ExternalArticleModel.fromJsonArray(json['ExternalArticles'])
    );
  }
  static fromJsonArray(List json) {
    return json.map((i)=>ArticleModel.fromJson(i)).toList();
  }
}

