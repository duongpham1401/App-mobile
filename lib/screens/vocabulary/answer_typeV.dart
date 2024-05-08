import 'package:english_app/controllers/vocabulary_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnswerTypeV extends StatefulWidget {
  const AnswerTypeV(
      {Key? key,
      required this.answerOption,
      required this.index,
      required this.onTap})
      : super(key: key);

  final String answerOption;
  final int index;
  final VoidCallback onTap;

  @override
  State<AnswerTypeV> createState() => _AnswerState();
}

class _AnswerState extends State<AnswerTypeV> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VocabularyController>(
        init: VocabularyController(),
        builder: (qnController) {
          Color getTheRightColor() {
            if (qnController.isAnswered) {
              if (widget.index == qnController.correctAns) {
                return Colors.green;
              } else if (widget.index == qnController.selectedAns &&
                  qnController.selectedAns != qnController.correctAns) {
                return Colors.red;
              }
            }
            return Colors.grey;
          }

          IconData getTheRightIcon() {
            return getTheRightColor() == Colors.red ? Icons.close : Icons.done;
          }

          return GestureDetector(
            onTap: widget.onTap,
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(color: getTheRightColor()),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.answerOption,
                      style: TextStyle(color: getTheRightColor(), fontSize: 18),
                    ),
                    Container(
                      height: 22,
                      width: 22,
                      decoration: BoxDecoration(
                          color: getTheRightColor() == Colors.grey
                              ? Colors.transparent
                              : getTheRightColor(),
                          border: Border.all(color: getTheRightColor()),
                          borderRadius: BorderRadius.circular(50)),
                      child: getTheRightColor() == Colors.grey
                          ? null
                          : Icon(getTheRightIcon(), size: 16,color: Colors.white,),
                    )
                  ]),
            ),
          );
        });
  }
}
