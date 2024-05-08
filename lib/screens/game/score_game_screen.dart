import 'package:english_app/controllers/determine_game_controller.dart';
import 'package:english_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScoreGameScreen extends StatefulWidget {
  const ScoreGameScreen({super.key});

  @override
  State<ScoreGameScreen> createState() => _ScoreGameScreenState();
}

class _ScoreGameScreenState extends State<ScoreGameScreen> {
  final DetermineGameController _controller = Get.put(DetermineGameController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller.updateRanking(_controller.numOfCorrectAns.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: hexStringToColor('ffffff'),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Image.asset('assets/images/game_score_top.jpg'),
            ),
            Text(
              'GREAT WORK',
              style: TextStyle(
                  color: hexStringToColor('e57086'),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Your Score',
                style: TextStyle(
                    color: hexStringToColor('1b1c20'),
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
            Text(
              _controller.numOfCorrectAns.toInt().toString(),
              style: TextStyle(
                  color: hexStringToColor('2a2b31'),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.upcoming),
                    label: Text('Rank'),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.replay),
                    label: Text('RePlay'),
                    onPressed: () {
                      _controller.rePlay();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                    onPressed: () {
                      _controller.goToHome();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}
