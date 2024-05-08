import 'dart:convert';

RankingGameModel rankingGameModelFromJson(String str) => RankingGameModel.fromJson(json.decode(str));

String rankingGameModelToJson(RankingGameModel data) => json.encode(data.toJson());

class RankingGameModel {
    RankingGameModel({
        required this.userId,
        required this.score,
        required this.timestamp,
        required this.gameId,
        required this.fullName,
    });

    String userId;
    int score;
    DateTime timestamp;
    int gameId;
    String fullName;

    factory RankingGameModel.fromJson(Map<String, dynamic> json) => RankingGameModel(
        userId: json["userId"],
        score: json["score"],
        timestamp: json["timestamp"],
        gameId: json["gameId"],
        fullName: json["fullName"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "score": score,
        "timestamp": timestamp,
        "gameId": gameId,
        "fullName": fullName,
    };
}
