import 'package:english_app/screens/navigator_screen.dart';
import 'package:english_app/screens/score/score_screen.dart';
import 'package:english_app/screens/vocabulary/home_typeV_screen.dart';
import 'package:english_app/screens/vocabulary/question_typeV_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:english_app/models/vocabulary_model.dart';

class VocabularyController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late PageController _pageController;
  PageController get pageController => this._pageController;

  List<VocabularyModel> questions = [];

  late int topicId;

  int _typeId = 1;
  int get typeId => this._typeId;

  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  late int _correctAns;
  int get correctAns => this._correctAns;

  late int _selectedAns;
  int get selectedAns => this._selectedAns;

  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => this._numOfCorrectAns;

  @override
  void onInit() {
    _pageController = PageController();
    questions = [];
    super.onInit();
  }

  // // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _pageController.dispose();
  }

  void checkAns(VocabularyModel question, int selectedIndex) {
    var crtAnswer;
    if (question.correctAnswer == 'A') {
      crtAnswer = 0;
    } else if (question.correctAnswer == 'B') {
      crtAnswer = 1;
    } else if (question.correctAnswer == 'C') {
      crtAnswer = 2;
    } else if (question.correctAnswer == 'D') {
      crtAnswer = 3;
    }
    // because once user press any option then it will run
    _isAnswered = true;
    _correctAns = crtAnswer;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) _numOfCorrectAns++;

    update();

    // Once user select an ans after 3s it will go to the next qn
    Future.delayed(Duration(seconds: 2), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);
    } else {
      // Get package provide us simple way to naviigate another page
      Get.to(() => const ScoreScreen(typeId: 1,));
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }

  void refreshController() {
    Get.delete<VocabularyController>();
  }

  void rePlay() {
    Get.delete<VocabularyController>();
    Get.to(QuestionTypeVScreen(
      topicId: topicId,
    ));
  }

  void goToHome() {
    Get.delete<VocabularyController>();
    Get.to(const NavigatorScreen(index: 1,));
  }
}
