import 'package:english_app/controllers/determine_game_controller.dart';
import 'package:english_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetermineGameAnswer extends StatefulWidget {
  const DetermineGameAnswer(
      {super.key,
      required this.answerOption,
      required this.onTap});

  final String answerOption;
  final VoidCallback onTap;

  @override
  State<DetermineGameAnswer> createState() => _DetermineGameAnswerState();
}

class _DetermineGameAnswerState extends State<DetermineGameAnswer> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetermineGameController>(
      init: DetermineGameController(),
      builder: (controller) {

        Color getBorderColor() {
            if (controller.isAnswered.value) {
              if (widget.answerOption == controller.correctAns) {
                return hexStringToColor('b6c8a9');
              } else if (widget.answerOption == controller.inputAns &&
                  controller.inputAns != controller.correctAns) {
                return hexStringToColor('ec805c');
              }
            }
            return hexStringToColor('e3e3e3');
          }

        Color getTextColor() {
            if (controller.isAnswered.value) {
              if (widget.answerOption == controller.correctAns) {
                return hexStringToColor('8bbe46');
              } else if (widget.answerOption == controller.inputAns &&
                  controller.inputAns != controller.correctAns) {
                return hexStringToColor('ec805c');
              }
            }
            return hexStringToColor('0f0f0f');
          }

        return GestureDetector(
          onTap: widget.onTap,
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: hexStringToColor('ffffff'),
                border: Border.all(color: getBorderColor(), width: 2),
                borderRadius: BorderRadius.circular(35)),
            child:
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                widget.answerOption,
                style: TextStyle(color: getTextColor(), fontSize: 17,fontWeight: FontWeight.w800),
              ),
            ]),
          ),
        );
      }
    );
  }
}
