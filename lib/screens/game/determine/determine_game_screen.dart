import 'package:english_app/controllers/determine_game_controller.dart';
import 'package:english_app/screens/game/determine/determine_game_question_card.dart';
import 'package:english_app/screens/game/guide_game_screen.dart';
import 'package:english_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetermineGameScreen extends StatefulWidget {
  const DetermineGameScreen({super.key});

  @override
  State<DetermineGameScreen> createState() => _DetermineGameScreenState();
}

class _DetermineGameScreenState extends State<DetermineGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: hexStringToColor('F99F34'),
          iconSize: 32,
          onPressed: () {
            Get.find<DetermineGameController>().refreshController();
            Get.to(() => GameGuideScreen(gameId: 1));
          },
        ),
        title: Text(
          "Determine Game Play",
          style: TextStyle(
              fontSize: 26,
              color: hexStringToColor('010101'),
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: hexStringToColor('F7F7F7'),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: GetX<DetermineGameController>(
          init: DetermineGameController(),
          builder: (controller) => Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Score : ${controller.numOfCorrectAns.toInt()}',
                      style: TextStyle(
                          color: hexStringToColor('101010'),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    buildStarIcons(controller.numOfInCorrectAns.toInt()),
                  ],
                ),
              ),
              Expanded(
                  child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller.pageController,
                      itemCount: controller.questions.length,
                      itemBuilder: (context, index) => Padding(
                            padding:
                                const EdgeInsets.fromLTRB(12.0, 12, 12.0, 12),
                            child: DetermineGameQuestionCard(
                                data: controller.questions[index]),
                          )))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStarIcons(numOfInCorrectAns) {
    List<Widget> starIcons = [];
    for (int i = 0; i < 3; i++) {
      if (i < numOfInCorrectAns) {
        starIcons.add(
            Icon(Icons.star, color: hexStringToColor("f7b254"), size: 24.0));
      } else {
        starIcons.add(Icon(Icons.star_border, color: Colors.grey, size: 24.0));
      }
    }
    return Row(children: starIcons);
  }
}
