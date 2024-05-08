import 'package:english_app/controllers/listen_controller.dart';
import 'package:english_app/models/listen_model.dart';
import 'package:english_app/screens/listen/answerTypeL.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

class QuestionCardTypeL extends StatefulWidget {
  const QuestionCardTypeL({Key? key, required this.data}) : super(key: key);

  final ListenModel data;

  @override
  State<QuestionCardTypeL> createState() => _QuestionCardTypeLState();
}

class _QuestionCardTypeLState extends State<QuestionCardTypeL> {
  bool isPlaying = false;
  AudioPlayer audioPlayer = AudioPlayer();
  String _inputWord = '';

  @override
  Widget build(BuildContext context) {
    ListenController _controller = Get.put(ListenController());

    return GetBuilder<ListenController>(
        init: ListenController(),
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
              children: [
                Stack(
                  children: [
                    Container(
                      // height: 200,
                      margin: EdgeInsets.only(top: 25),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: getTheRightColor(),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 45, 15, 30),
                        child: Text(
                          widget.data.questionText,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 24.0,
                            color: getTheRightColor(),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: CircleAvatar(
                        radius: 30,
                        child: IconButton(
                          icon:
                              Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                          iconSize: 36,
                          onPressed: () async {
                            if (isPlaying) {
                              pauseSound();
                            } else {
                              playSound(widget.data.voiceUrl);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                AnswerTypeL(
                  answer: widget.data.answer,
                  onInputValuesChanged: onInputValuesChanged,
                  color: getTheRightColor()
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

  void playSound(String url) async {
    setState(() {
      isPlaying = true;
    });
    await audioPlayer.play(UrlSource(url));

    audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
      });
    });
  }

  void pauseSound() async {
    await audioPlayer.pause();

    setState(() {
      isPlaying = false;
    });
  }

  void onInputValuesChanged(List<String> inputValues) {
    String inputWord = inputValues.join('');
    setState(() {
      _inputWord = inputWord;
    });
  }
}
