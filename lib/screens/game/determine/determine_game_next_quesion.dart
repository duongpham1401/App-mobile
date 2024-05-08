import 'package:english_app/controllers/determine_game_controller.dart';
import 'package:english_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';

class DetermineGameNextQuestion extends StatefulWidget {
  const DetermineGameNextQuestion({super.key, required this.sentence});

  final String sentence;

  @override
  State<DetermineGameNextQuestion> createState() =>
      _DetermineGameNextQuestionState();
}

class _DetermineGameNextQuestionState extends State<DetermineGameNextQuestion> {
  final String _fromLanguage = 'en';
  final String _toLanguage = 'vi';
  String meaningOfSentence = '';
  bool _visible = false;

  void _translate() async {
    final translator = GoogleTranslator();
    final translatedText = await translator.translate(widget.sentence,
        from: _fromLanguage, to: _toLanguage);
    setState(() {
      meaningOfSentence = translatedText.toString();
      _visible = true;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    _translate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DetermineGameController _controller = Get.put(DetermineGameController());

    return Visibility(
      visible: _visible,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: hexStringToColor('ffffff'),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: Image.asset(
                      'assets/images/idea.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                  Text(
                    'The meaning of the sentence',
                    style: TextStyle(
                        color: hexStringToColor('111111'),
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 58.0),
              child: Text(
                meaningOfSentence,
                style: TextStyle(
                    color: hexStringToColor('010101'),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10),
              child: ElevatedButton(
                  onPressed: () {
                    _controller.nextQuestion();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        hexStringToColor('8ec14a')),
                    minimumSize:
                        MaterialStateProperty.all<Size>(const Size(180, 50)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  child: Obx(() {
                    return Text(
                      _controller.numOfInCorrectAns.toInt() != 0
                          ? 'Next Question'
                          : 'Finish',
                      style: TextStyle(
                          fontSize: 16, color: hexStringToColor('fbfcf3')),
                    );
                  })),
            )
          ],
        ),
      ),
    );
  }
}
