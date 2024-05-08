import 'package:english_app/controllers/vocabulary_controller.dart';
import 'package:english_app/screens/vocabulary/question_card_typeV.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/vocabulary_model.dart';

class BodyQuestionTypeVScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VocabularyController _controller = Get.put(VocabularyController());
    return Stack(children: <Widget>[
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg11.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: Column(children: [
          Obx(() {
            return Row(
              children: <Widget>[
                Text(
                  "Question ${_controller.questionNumber.value}",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "/${_controller.questions.length}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ],
            );
          }),
          const Divider(
            thickness: 2.5,
          ),
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: PageView.builder(
                // Block swipe to next qn
                physics: const NeverScrollableScrollPhysics(),
                controller: _controller.pageController,
                onPageChanged: _controller.updateTheQnNum,
                itemCount: _controller.questions.length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                      child: QuestionCardTypeV(
                        data: VocabularyModel(
                            id: int.parse(
                                _controller.questions[index].id.toString()),
                            questionImg:
                                _controller.questions[index].questionImg,
                            answerA: _controller.questions[index].answerA,
                            answerB: _controller.questions[index].answerB,
                            answerC: _controller.questions[index].answerC,
                            answerD: _controller.questions[index].answerD,
                            correctAnswer:
                                _controller.questions[index].correctAnswer,
                            topicId: int.parse(_controller
                                .questions[index].topicId
                                .toString())),
                      ),
                    )),
          ),
        ]),
      ))
    ]);
  }
}
