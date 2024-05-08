import 'package:english_app/controllers/grammar_controller.dart';
import 'package:english_app/models/grammar_model.dart';
import 'package:english_app/screens/grammar/answerTypeG.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionCardTypeG extends StatefulWidget {
  const QuestionCardTypeG({Key? key, required this.data}) : super(key: key);

  final GrammarModel data;

  @override
  State<QuestionCardTypeG> createState() => _QuestionCardTypeGState();
}

class _QuestionCardTypeGState extends State<QuestionCardTypeG> {
  String _inputWord = '';

  @override
  Widget build(BuildContext context) {
    GrammarController _controller = Get.put(GrammarController());

    return GetBuilder<GrammarController>(
        init: GrammarController(),
        builder: (_controller) {
          Color getTheRightColor() {
            if (_controller.isAnswered) {
              if (_inputWord == _controller.correctAns) {
                return Colors.green;
              } else if (_controller.inputAns == _inputWord &&
                  _controller.correctAns != _inputWord) {
                return Colors.red;
              }
            }
            return Colors.black87;
          }

          return Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(25.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.data.question != ''
                    ? Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          widget.data.question,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 24.0,
                            color: Colors.black,
                          ),
                        ),
                      )
                    : const Text(
                        "Arrange the words to make complete sentences",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18.0,
                          color: Colors.black87,
                        ),
                      ),
                Container(
                  width: 310.0,
                  constraints: BoxConstraints(minHeight: 360.0),
                  margin: EdgeInsets.only(top: 0),
                  child: AnswerTypeG(
                    wordList: widget.data.wordList,
                    onAnswerValuesChanged: onAnswerValuesChanged,
                    color:  getTheRightColor(),
                  ),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.check),
                  label: Text('Check'),
                  onPressed: () {
                    _controller.checkAns(widget.data, _inputWord);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void onAnswerValuesChanged(List<String> answerValues) {
    String inputWord = answerValues.join(' ');
    print(inputWord);
    setState(() {
      _inputWord = inputWord;
    });
  }
}
