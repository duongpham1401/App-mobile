import 'dart:async';
import 'package:english_app/screens/game/determine/determine_game_screen.dart';
import 'package:english_app/screens/game/home_game_screen.dart';
import 'package:english_app/screens/game/rankings_game_screen.dart';
import 'package:english_app/screens/navigator_screen.dart';
import 'package:english_app/utils/color_utils.dart';
import 'package:get/get.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GameGuideScreen extends StatefulWidget {
  final int gameId;

  GameGuideScreen({required this.gameId});

  @override
  _GameGuideScreenState createState() => _GameGuideScreenState();
}

class _GameGuideScreenState extends State<GameGuideScreen> {
  late Stream<QuerySnapshot> _guideStream;
  List<String> _guideImages = [];
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _guideStream = FirebaseFirestore.instance
        .collection('games')
        .where('id', isEqualTo: widget.gameId)
        .snapshots();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Game Guide",
          style: TextStyle(
              fontSize: 26,
              color: hexStringToColor('35406E'),
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: hexStringToColor('35406E'),
          iconSize: 32,
          onPressed: () {
            Get.to(() => NavigatorScreen(index: 4,));
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _guideStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          QuerySnapshot guideSnapshot = snapshot.data!;
          List<dynamic> guide = guideSnapshot.docs.first.get('guide');
          _guideImages = guide.cast<String>();

          return Container(
            color: Colors.black12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  children: <Widget>[
                    _buildPageView(_guideImages),
                    _buildCircleIndicator(_guideImages),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(Icons.upcoming),
                      label: Text('Rank'),
                      onPressed: () {
                        Get.to(() => RankingsGameScreen(gameId: widget.gameId));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      icon: Icon(Icons.play_arrow),
                      label: Text('Play'),
                      onPressed: () {
                        if (widget.gameId == 1) {
                          Get.to(() => DetermineGameScreen());
                        }
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
              ],
            ),
          );
        },
      ),
    );
  }

  _buildPageView(items) {
    return SizedBox(
      width: 340,
      height: 500,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: PageView.builder(
            itemCount: items.length,
            controller: _pageController,
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                items[index],
                fit: BoxFit.cover,
              );
            },
            onPageChanged: (int index) {
              _currentPageNotifier.value = index;
            }),
      ),
    );
  }

  _buildCircleIndicator(item) {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CirclePageIndicator(
          size: 10,
          selectedSize: 15,
          itemCount: item.length,
          currentPageNotifier: _currentPageNotifier,
        ),
      ),
    );
  }
}
