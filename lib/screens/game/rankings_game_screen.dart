import 'package:english_app/component/loading_overlay.dart';
import 'package:english_app/controllers/rankings_game_controller.dart';
import 'package:english_app/models/ranking_game_model.dart';
import 'package:english_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RankingsGameScreen extends StatefulWidget {
  const RankingsGameScreen({super.key, required this.gameId});

  final int gameId;

  @override
  State<RankingsGameScreen> createState() => _RankingsGameScreenState();
}

class _RankingsGameScreenState extends State<RankingsGameScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RankingsGameController(gameId: widget.gameId));

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: hexStringToColor('FFFFFF'),
            iconSize: 32,
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            "Rankings",
            style: TextStyle(
                fontSize: 26,
                color: hexStringToColor('FFFFFF'),
                fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: 320,
                  child: Image.asset(
                    'assets/images/top_rank.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            ClipRRect(
                              child: Image.asset(
                                'assets/images/rank2.png',
                                width: 80,
                                height: 80,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                controller.rankings.length >= 2
                                    ? controller.rankings[1].fullName
                                    : '',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Container(
                              width: 90,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: hexStringToColor('97e4ee'),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              child: Center(
                                child: Text(
                                  controller.rankings.length >= 2
                                      ? controller.rankings[1].score.toString()
                                      : '',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ClipRRect(
                              child: Image.asset(
                                'assets/images/rank1.png',
                                width: 80,
                                height: 80,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                controller.rankings.length >= 1
                                    ? controller.rankings[0].fullName
                                    : '',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                  color: hexStringToColor('ed6046'),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              child: Center(
                                child: Text(
                                  controller.rankings.length >= 1
                                      ? controller.rankings[0].score.toString()
                                      : '',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ClipRRect(
                              child: Image.asset(
                                'assets/images/rank3.png',
                                width: 80,
                                height: 80,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                controller.rankings.length >= 3
                                    ? controller.rankings[2].fullName
                                    : '',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Container(
                              width: 90,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: hexStringToColor('b3d3ff'),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              child: Center(
                                child: Text(
                                  controller.rankings.length >= 3
                                      ? controller.rankings[2].score.toString()
                                      : '',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ]),
              Expanded(
                  child: Container(
                    height: 360,
                    color: Colors.transparent,
                    padding: EdgeInsets.all(20),
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 0.0),
                      itemCount: controller.rankings.length >= 4
                          ? controller.rankings.length - 3
                          : 0,
                      itemBuilder: (BuildContext context, int index) {
                        final int adjustedIndex = index + 3;
                        final RankingGameModel ranking =
                            controller.rankings[adjustedIndex];
                        return buildListItem(
                            adjustedIndex, ranking.fullName, ranking.score);
                      },
                    ),
                  ),
                ),
            ],
          );
        }));
  }
}

Widget buildListItem(int index, String name, int score) {
  return Container(
    height: 50,
    margin: EdgeInsets.only(top: 10),
    decoration: BoxDecoration(
      color: hexStringToColor('F2F2F2'),
      borderRadius: BorderRadius.circular(40),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle
          ),
          child: Center(
            child: Text(
              (index + 1).toString(),
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 18.0),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Text(
                  score.toString(),
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
