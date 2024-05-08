import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ListenModel listenModelFromJson(String str) =>
    ListenModel.fromJson(json.decode(str));

String listenModelToJson(ListenModel data) => json.encode(data.toJson());

class ListenModel {
  ListenModel({
    required this.id,
    required this.topicId,
    required this.questionText,
    required this.voiceUrl,
    required this.answer,
  });

  int id;
  int topicId;
  String questionText;
  String voiceUrl;
  String answer;

  factory ListenModel.fromJson(Map<String, dynamic> json) => ListenModel(
        id: json["id"],
        topicId: json["topicId"],
        questionText: json["questionText"],
        voiceUrl: json["voiceUrl"],
        answer: json["answer"],
      );

  factory ListenModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ListenModel(
      id: data["id"],
      topicId: data["topicId"],
      questionText: data["questionText"],
      voiceUrl: data["voiceUrl"],
      answer: data["answer"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "topicId": topicId,
        "questionText": questionText,
        "voiceUrl": voiceUrl,
        "answer": answer,
      };
}
