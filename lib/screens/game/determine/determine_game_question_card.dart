import 'package:english_app/controllers/determine_game_controller.dart';
import 'package:english_app/models/determine_game_model.dart';
import 'package:english_app/screens/game/determine/determine_game_answer.dart';
import 'package:english_app/screens/game/determine/determine_game_next_quesion.dart';
import 'package:english_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetermineGameQuestionCard extends StatefulWidget {
  const DetermineGameQuestionCard({super.key, required this.data});

  final DetermineGameModel data;

  @override
  State<DetermineGameQuestionCard> createState() =>
      _DetermineGameQuestionCardState();
}

class _DetermineGameQuestionCardState extends State<DetermineGameQuestionCard> {
  late List<String> shuffledOptions;

  @override
  void initState() {
    // TODO: implement initState
    shuffledOptions = List.from(widget.data.options)..shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DetermineGameController _controller = Get.put(DetermineGameController());

    return Column(
      children: [
        Divider(
          thickness: 5,
          color: hexStringToColor('DBE7F2'),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 10, 8, 10),
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 15, color: hexStringToColor('101010')),
              children: [
                const TextSpan(
                  text: 'Identify the ',
                ),
                TextSpan(
                  text: widget.data.target,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text: ' in the following sentence',
                ),
              ],
            ),
          ),
        ),
        Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(colors: [
                  hexStringToColor("f7b254"),
                  hexStringToColor("f4ca5d")
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 20, 16, 20),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.data.sentence.substring(0,
                          widget.data.sentence.indexOf(widget.data.decoration)),
                      style: TextStyle(
                        fontSize: 18,
                        color: hexStringToColor('040700'),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: widget.data.decoration,
                      style: TextStyle(
                        fontSize: 18,
                        color: hexStringToColor('040700'),
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(
                      text: widget.data.sentence.substring(
                          widget.data.sentence.indexOf(widget.data.decoration) +
                              widget.data.decoration.length),
                      style: TextStyle(
                        fontSize: 18,
                        color: hexStringToColor('040700'),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )),
        ...List.generate(
            shuffledOptions.length,
            (index) => DetermineGameAnswer(
                answerOption: shuffledOptions[index],
                onTap: () => !_controller.isAnswered.value
                    ? _controller.checkAns(
                        widget.data, shuffledOptions[index])
                    : null)),
        const SizedBox(
          height: 50,
        ),
        Obx(() {
          if (_controller.isAnswered.value) {
            return DetermineGameNextQuestion(sentence: widget.data.sentence);
          } else {
            return SizedBox.shrink();
          }
        }),
      ],
    );
  }
}
