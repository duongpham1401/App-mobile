import 'package:english_app/component/drawer.dart';
import 'package:english_app/component/overview_chart.dart';
import 'package:english_app/component/weekly_exercise_chart.dart';
import 'package:english_app/controllers/auth_controller.dart';
import 'package:english_app/models/user_model.dart';
import 'package:english_app/screens/navigator_screen.dart';
import 'package:english_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    // ignore: no_leading_underscores_for_local_identifiers
    AuthController _controller = Get.put(AuthController());

    return Scaffold(
      appBar: null,
      key: _scaffoldKey,
      drawer: const NavigatorDrawer(),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: const Color.fromRGBO(255, 255, 255, 1),
          ),
          Positioned(
            top: 25,
            left: 5,
            child: CircleAvatar(
              radius: 26,
              backgroundColor: Colors.transparent,
              foregroundColor: hexStringToColor('35406E'),
              child: IconButton(
                iconSize: 32,
                icon: const Icon(Icons.menu),
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FutureBuilder(
                  future: _controller.getUserDetail(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    UserModel userData = snapshot.data as UserModel;
                    return Container(
                      margin: const EdgeInsets.fromLTRB(40, 32, 0, 0),
                      child: Text(
                        'Hello ${userData.fullName}',
                        style: TextStyle(
                            fontSize: 32,
                            color: hexStringToColor('35406E'),
                            fontWeight: FontWeight.w700),
                      ),
                    );
                  }),
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: const <Widget>[
                        WeeklyExerciseChart(),
                        SizedBox(
                          height: 30,
                        ),
                        OverviewChart(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
