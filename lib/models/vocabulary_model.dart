import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

VocabularyModel vocabularyModelFromJson(String str) =>
    VocabularyModel.fromJson(json.decode(str));

String vocabularyModelToJson(VocabularyModel data) =>
    json.encode(data.toJson());

class VocabularyModel {
  VocabularyModel({
    required this.id,
    required this.questionImg,
    required this.answerA,
    required this.answerB,
    required this.answerC,
    required this.answerD,
    required this.correctAnswer,
    required this.topicId,
  });

  int id;
  String questionImg;
  String answerA;
  String answerB;
  String answerC;
  String answerD;
  String correctAnswer;
  int topicId;

  factory VocabularyModel.fromJson(Map<String, dynamic> json) =>
      VocabularyModel(
        id: json["id"],
        questionImg: json["questionImg"],
        answerA: json["answerA"],
        answerB: json["answerB"],
        answerC: json["answerC"],
        answerD: json["answerD"],
        correctAnswer: json["correctAnswer"],
        topicId: json["topicId"],
      );

  factory VocabularyModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    
    final data = document.data()!;
    return VocabularyModel(
      id: data["id"],
      questionImg: data["questionImg"],
      answerA: data["answerA"],
      answerB: data["answerB"],
      answerC: data["answerC"],
      answerD: data["answerD"],
      correctAnswer: data["correctAnswer"],
      topicId: data["topicId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "questionImg": questionImg,
        "answerA": answerA,
        "answerB": answerB,
        "answerC": answerC,
        "answerD": answerD,
        "correctAnswer": correctAnswer,
        "topicId": topicId,
      };
}
