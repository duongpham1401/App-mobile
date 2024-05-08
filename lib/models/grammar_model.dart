import 'dart:convert';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';

GrammarModel grammarModelFromJson(String str) =>
    GrammarModel.fromJson(json.decode(str));

String grammarModelToJson(GrammarModel data) => json.encode(data.toJson());

class GrammarModel {
  GrammarModel({
    required this.id,
    required this.topicId,
    required this.question,
    required this.wordList,
    required this.answer,
  });

  int id;
  int topicId;
  String question;
  List<String> wordList;
  String answer;

  factory GrammarModel.fromJson(Map<String, dynamic> json) => GrammarModel(
        id: json["id"],
        topicId: json["topicId"],
        question: json["question"],
        wordList: json["wordList"],
        answer: json["answer"],
      );

  factory GrammarModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!.cast<String, Object?>();
    return GrammarModel(
      id: data["id"] as int,
      topicId: data["topicId"] as int,
      question: data["question"] as String,
      wordList:
          (data["wordList"] as List<dynamic>).map((e) => e.toString()).toList(),
      answer: data["answer"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "topicId": topicId,
        "question": question,
        "wordList": wordList,
        "answer": answer,
      };
}
