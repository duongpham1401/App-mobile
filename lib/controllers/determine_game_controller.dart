import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_app/models/determine_game_model.dart';
import 'package:english_app/screens/game/determine/determine_game_screen.dart';
import 'package:english_app/screens/game/home_game_screen.dart';
import 'package:english_app/screens/game/score_game_screen.dart';
import 'package:english_app/screens/navigator_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';

class DetermineGameController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _db = FirebaseFirestore.instance;

  late PageController _pageController;
  PageController get pageController => this._pageController;

  final questions = <DetermineGameModel>[].obs;

  final int gameId = 1;

  RxBool _isAnswered = false.obs;
  RxBool get isAnswered => this._isAnswered;

  late String _inputAns;
  String get inputAns => _inputAns;

  late String _correctAns;
  String get correctAns => _correctAns;

  RxInt _numOfInCorrectAns = 3.obs;
  RxInt get numOfInCorrectAns => this._numOfInCorrectAns;

  RxInt _numOfCorrectAns = 0.obs;
  RxInt get numOfCorrectAns => this._numOfCorrectAns;

  @override
  void onInit() {
    _pageController = PageController();
    getQuestions();
    super.onInit();
  }

  // // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _pageController.dispose();
  }

  Future<void> getQuestions() async {
    final snapshot =
        await FirebaseFirestore.instance.collectionGroup('quizs').get();

    final questionsList = snapshot.docs
        .map((doc) => DetermineGameModel(
              id: doc['id'],
              target: doc['target'],
              sentence: doc['sentence'],
              options: doc['options'].cast<String>(),
              decoration: doc['decoration'],
              answer: doc['answer'],
            ))
        .toList();

    // Xáo trộn thứ tự của các câu hỏi
    questionsList.shuffle(Random());

    questions.assignAll(questionsList);
  }

  void checkAns(DetermineGameModel question, String userAnswer) {
    _inputAns = userAnswer;
    // // because once user press any option then it will run
    _isAnswered.value = true;
    _correctAns = question.answer;

    if (_correctAns == _inputAns) {
      _numOfCorrectAns++;
    } else {
      _numOfInCorrectAns--;
    }

    update();
  }

  void nextQuestion() {
    if (_numOfInCorrectAns.value > 0) {
      if ((_pageController.page! + 1.0).toInt() != questions.length) {
        _isAnswered.value = false;
        _pageController.nextPage(
            duration: Duration(milliseconds: 250), curve: Curves.ease);
      } else {
        Get.to(() => ScoreGameScreen());
      }
    } else {
      Get.to(() => ScoreGameScreen());
    }
  }

  void refreshController() {
    Get.delete<DetermineGameController>();
  }

  void rePlay() {
    Get.delete<DetermineGameController>();
    Get.to(() => DetermineGameScreen());
  }

  void goToHome() {
    Get.delete<DetermineGameController>();
    Get.to(const NavigatorScreen(
      index: 4,
    ));
  }

  Future<void> updateRanking(int newScore) async {
    final rankingsRef = FirebaseFirestore.instance.collection('rankings');
    final currentUser = FirebaseAuth.instance.currentUser;
    final userDocSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser?.uid)
        .get();

    if (userDocSnapshot.exists) {
      final userData = userDocSnapshot.data()!;
      final userId = userData['id'];
      final fullName = userData['fullName'];

      DateTime now = DateTime.now();

      final rankingDocSnapshot = await rankingsRef.doc('$userId:$gameId').get();

      if (rankingDocSnapshot.exists) {
        final rankingData = rankingDocSnapshot.data()!;
        final int oldScore = rankingData['score'];
        if (newScore > oldScore) {
          await rankingDocSnapshot.reference.update({
            'score': newScore,
            'timestamp': now,
          });
        }
      } else {
        await rankingsRef.doc('$userId:$gameId').set({
          'userId': userId,
          'gameId': gameId,
          'score': newScore,
          'fullName': fullName,
          'timestamp': now,
        });
      }
    }
  }
}
