import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

DetermineGameModel determineGameModelFromJson(String str) =>
    DetermineGameModel.fromJson(json.decode(str));

String determineGameModelToJson(DetermineGameModel data) =>
    json.encode(data.toJson());

class DetermineGameModel {
  DetermineGameModel({
    required this.id,
    required this.target,
    required this.sentence,
    required this.options,
    required this.answer,
    required this.decoration,
  });

  int id;
  String target;
  String sentence;
  List<String> options;
  String answer;
  String decoration;

  factory DetermineGameModel.fromJson(Map<String, dynamic> json) =>
      DetermineGameModel(
        id: json["id"],
        target: json["target"],
        sentence: json["sentence"],
        options: json["options"],
        answer: json["answer"],
        decoration: json["decoration"],
      );

  factory DetermineGameModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!.cast<String, Object?>();
    return DetermineGameModel(
      id: data["id"] as int,
      target: data["target"] as String,
      sentence: data["sentence"] as String,
      options:
          (data["options"] as List<dynamic>).map((e) => e.toString()).toList(),
      answer: data["answer"] as String,
      decoration: data["decoration"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "target": target,
        "sentence": sentence,
        "options": options,
        "answer": answer,
        "decoration": decoration,
      };
}
