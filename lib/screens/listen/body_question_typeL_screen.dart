import 'package:english_app/controllers/listen_controller.dart';
import 'package:english_app/models/listen_model.dart';
import 'package:english_app/screens/listen/question_card_typeL.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BodyQuestionTypeLScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ListenController _controller = Get.put(ListenController());
    return Stack(children: <Widget>[
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg1.jpg"),
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
                      fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                ),
                Text(
                  "/${_controller.questions.length}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white70),
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
                      child: QuestionCardTypeL(
                        data: ListenModel(
                            id: int.parse(
                                _controller.questions[index].id.toString()),
                            questionText:
                                _controller.questions[index].questionText,
                            voiceUrl: _controller.questions[index].voiceUrl,
                            answer: _controller.questions[index].answer,
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
