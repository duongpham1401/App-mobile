import 'package:english_app/component/drawer.dart';
import 'package:english_app/component/loading_overlay.dart';
import 'package:english_app/screens/game/guide_game_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeGameScreen extends StatefulWidget {
  // const HomeGameScreen({super.key});

  @override
  _HomeGameScreenState createState() => _HomeGameScreenState();
}

class _HomeGameScreenState extends State<HomeGameScreen> {
  final Stream<QuerySnapshot> _gamesStream =
      FirebaseFirestore.instance.collection('games').orderBy('id').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Games"),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0.0,
      ),
      drawer: const NavigatorDrawer(),
      body: SingleChildScrollView(
          child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: StreamBuilder<QuerySnapshot>(
              stream: _gamesStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingOverlay();
                }

                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return gameView(
                        context, data['image'], data['name'], () {
                          Get.to(() => GameGuideScreen(gameId: data['id']));
                        });
                  }).toList(),
                );
              }),
        ),
      )),
    );
  }
}

Container gameView(
    BuildContext context, String imageUrl, String topicName, Function onTap) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    decoration: BoxDecoration(
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.grey.withOpacity(0.6),
          offset: const Offset(4, 4),
          blurRadius: 16,
        ),
      ],
    ),
    child: InkWell(
      onTap: () {
        onTap();
      },
      child: Card(
        elevation: 0.0,
        child: Stack(
          children: [
            SizedBox(
                height: 200,
                child: Image.network(
                  height: 200,
                  width: 380,
                  imageUrl,
                  fit: BoxFit.fill,
                )),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8),
                color: Colors.black.withOpacity(0.5),
                child: Text(
                  topicName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Container gameView2(
    BuildContext context, String imageUrl, String name, Function onTap) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.grey.withOpacity(0.6),
          offset: const Offset(4, 4),
          blurRadius: 16,
        ),
      ],
    ),
    child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 2,
              child: SizedBox(
                  height: 200,
                  child: Image.network(
                    height: 200,
                    width: 380,
                    imageUrl,
                    fit: BoxFit.fill,
                  )),
            ),
            Container(
                padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                color: Colors.white,
                child: Center(
                  child: Text(
                    '${name}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                )),
          ],
        )),
  );
}
