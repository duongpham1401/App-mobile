import 'package:english_app/models/listen_model.dart';
import 'package:english_app/screens/listen/home_typeL_screen.dart';
import 'package:english_app/screens/listen/question_typeL_screen.dart';
import 'package:english_app/screens/navigator_screen.dart';
import 'package:english_app/screens/score/score_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late PageController _pageController;
  PageController get pageController => _pageController;

  List<ListenModel> questions = [];

  late int topicId;

  int _typeId = 3;
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

  void checkAns(ListenModel question, String inputWord) {
    // print("Controller : "+ inputWord);
    _inputAns = inputWord;
    // // because once user press any option then it will run
    _isAnswered = true;
    _correctAns = question.answer;
    // _selectedAns = selectedIndex;

    if (_correctAns == _inputAns) _numOfCorrectAns++;

    update();

    // Once user select an ans after 2s it will go to the next qn
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
      Get.to(() => const ScoreScreen(typeId: 3,));
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }

  void refreshController() {
    Get.delete<ListenController>();
  }

  void rePlay() {
    Get.delete<ListenController>();
    Get.to(QuestionTypeLScreen(
      topicId: topicId,
    ));
  }

  void goToHome() {
    Get.delete<ListenController>();
    Get.to(const NavigatorScreen(index: 3,));
  }
}
