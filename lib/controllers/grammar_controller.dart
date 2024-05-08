import 'package:english_app/models/grammar_model.dart';
import 'package:english_app/screens/grammar/home_typeG_screen.dart';
import 'package:english_app/screens/listen/question_typeL_screen.dart';
import 'package:english_app/screens/navigator_screen.dart';
import 'package:english_app/screens/score/score_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GrammarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late PageController _pageController;
  PageController get pageController => _pageController;

  List<GrammarModel> questions = [];

  late int topicId;

  int _typeId = 2;
  int get typeId => _typeId;

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  late String _correctAns;
  String get correctAns => _correctAns;

  late String _inputAns;
  String get inputAns => _inputAns;

  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;

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

  void checkAns(GrammarModel question, String inputAnswer) {
    _inputAns = inputAnswer;
    // // because once user press any option then it will run
    _isAnswered = true;
    _correctAns = question.answer;
    // _selectedAns = selectedIndex;

    if (_correctAns == _inputAns) _numOfCorrectAns++;

    update();

    // Once user select an ans after 2s it will go to the next qn
    Future.delayed(const Duration(seconds: 2), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);
    } else {
      // Get package provide us simple way to naviigate another page
      Get.to(() => const ScoreScreen(typeId: 2,));
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }

  void refreshController() {
    Get.delete<GrammarController>();
  }

  void rePlay() {
    Get.delete<GrammarController>();
    Get.to(QuestionTypeLScreen(
      topicId: topicId,
    ));
  }

  void goToHome() {
    Get.delete<GrammarController>();
    Get.to(const NavigatorScreen(index: 2,));
  }
}
