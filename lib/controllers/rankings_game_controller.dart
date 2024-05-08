import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_app/models/ranking_game_model.dart';
import 'package:get/get.dart';

class RankingsGameController extends GetxController {
  RankingsGameController({
    required this.gameId,
  });

  final int gameId;

  var rankings = <RankingGameModel>[].obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  @override
  void onReady() {
    getData();
    super.onReady();
  }

  Future<void> getData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('rankings')
        .where('gameId', isEqualTo: gameId)
        .orderBy('score', descending: true)
        .orderBy('timestamp', descending: false)
        .get();

    final rankingsList = snapshot.docs
        .map((doc) => RankingGameModel(
              userId: doc['userId'],
              fullName: doc['fullName'],
              gameId: doc['gameId'],
              score: doc['score'],
              timestamp: doc['timestamp'].toDate(),
            ))
        .toList();

    print(rankingsList);

    rankings.value = rankingsList;
  }
}
