import 'package:english_app/controllers/grammar_controller.dart';
import 'package:english_app/controllers/listen_controller.dart';
import 'package:english_app/controllers/progress_controller.dart';
import 'package:english_app/controllers/vocabulary_controller.dart';
import 'package:english_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key, required this.typeId});

  final int typeId;

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  late dynamic _qnController;
  final ProgressController _pgController = Get.put(ProgressController());

  bool isWin() {
    if (_qnController.numOfCorrectAns / _qnController.questions.length >= 0.8) {
      return true;
    }
    return false;
  }

  updateFireStore() async {
    if (await _pgController.isHasProgress(
        _qnController.topicId, _qnController.typeId) == false) {
      _pgController.addProcess(
          _qnController.topicId, _qnController.typeId, isWin());
    } else {
      if (await _pgController.isInProgress(
              _qnController.topicId, _qnController.typeId) &&
          isWin()) {
        _pgController.updateProcess(
            _qnController.topicId, _qnController.typeId);
      } else if (isWin()) {
        _pgController.addProcess(
            _qnController.topicId, _qnController.typeId, true);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.typeId == 1) {
      _qnController = Get.put(VocabularyController());
    } else if (widget.typeId == 2) {
      _qnController = Get.put(GrammarController());
    } else {
      _qnController = Get.put(ListenController());
    }

    updateFireStore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Results'),
        centerTitle: true,
        backgroundColor: isWin() ? Colors.green : Colors.red,
      ),
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isWin()
                  ? [hexStringToColor("A2D6AD"), hexStringToColor("7ACBA5")]
                  : [hexStringToColor("FFC4B7"), hexStringToColor("FF8A80")],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 300,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    isWin() ? Colors.white70 : Colors.pink,
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(isWin()
                      ? 'assets/images/win.png'
                      : 'assets/images/lose.png'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Score : ",
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "${_qnController.numOfCorrectAns}",
                    style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "/",
                    style: TextStyle(
                        color: Colors.white60,
                        fontSize: 30,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "${_qnController.questions.length}",
                    style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 30,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.replay),
                    label: Text('Replay'),
                    onPressed: () {
                      _qnController.rePlay();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                    onPressed: () {
                      _qnController.goToHome();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isWin() ? Colors.green : Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
