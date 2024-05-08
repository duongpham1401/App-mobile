import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:english_app/screens/game/home_game_screen.dart';
import 'package:english_app/screens/grammar/home_typeG_screen.dart';
import 'package:english_app/screens/home_screen.dart';
import 'package:english_app/screens/listen/home_typeL_screen.dart';
import 'package:english_app/screens/vocabulary/home_typeV_screen.dart';
import 'package:flutter/material.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key, required this.index});

  final int index;

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  late int index;
  final screens = [
    HomeScreen(),
    HomeTypeVScreen(),
    HomeTypeGScreen(),
    HomeTypeLScreen(),
    HomeGameScreen()
  ];
  @override
  void initState() {
    index =widget.index;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(
        Icons.home,
        size: 30,
      ),
      Icon(
        Icons.abc_sharp,
        size: 30,
      ),
      Icon(
        Icons.border_color,
        size: 30,
      ),
      Icon(
        Icons.headphones,
        size: 30,
      ),
      Icon(
        Icons.games,
        size: 30,
      ),
    ];
    return Scaffold(
      extendBody: true,
      body: screens[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          height: 50,
          backgroundColor: Colors.transparent,
          color: Colors.blue,
          index: index,
          items: items,
          onTap: (index) => setState(() {
            this.index = index;
          }),
        ),
      ),
    );
  }
}
