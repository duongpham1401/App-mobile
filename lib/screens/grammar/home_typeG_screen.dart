import 'package:english_app/component/drawer.dart';
import 'package:english_app/component/loading_overlay.dart';
import 'package:english_app/screens/grammar/question_typeG_screen.dart';
import 'package:english_app/screens/navigator_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'view_topic_typeG.dart';

class HomeTypeGScreen extends StatefulWidget {
  const HomeTypeGScreen({super.key});

  @override
  _HomeTypeGScreenState createState() => _HomeTypeGScreenState();
}

class _HomeTypeGScreenState extends State<HomeTypeGScreen> {
  Stream<List<Map<String, dynamic>>> topicByUser() {
    return FirebaseFirestore.instance
        .collectionGroup('grammar_topics')
        // .orderBy('id')
        .snapshots()
        .asyncMap((topicQuerySnapShot) async {
      List<Map<String, dynamic>> topicByUserList = [];

      var currentUser = FirebaseAuth.instance.currentUser;

      for (DocumentSnapshot topicDoc in topicQuerySnapShot.docs) {
        QuerySnapshot processQuerySnapshot = await FirebaseFirestore.instance
            .collection('progress')
            .where('userId', isEqualTo: currentUser?.uid)
            .where('topicId', isEqualTo: topicDoc.get('id'))
            .where('typeId', isEqualTo: 2)
            .get();

        if (processQuerySnapshot.docs.isNotEmpty) {
          DocumentSnapshot processDoc = processQuerySnapshot.docs.first;

          Map<String, dynamic> topicByUserMap = {
            'userId': currentUser?.uid,
            'topicId': processDoc.get('topicId'),
            'name': topicDoc.get('name'),
            'image': topicDoc.get('img'),
            'status': processDoc.get('status'),
          };

          topicByUserList.add(topicByUserMap);
        } else if (processQuerySnapshot.docs.isEmpty) {
          Map<String, dynamic> topicByUserMap = {
            'userId': currentUser?.uid,
            'topicId': topicDoc.get('id'),
            'name': topicDoc.get('name'),
            'image': topicDoc.get('img'),
            'status': "Not Started",
          };

          topicByUserList.add(topicByUserMap);
        }
      }

      return topicByUserList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Grammar"),
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
          child: StreamBuilder<List<Map<String, dynamic>>>(
            stream: topicByUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Map<String, dynamic>>? topicByUserList = snapshot.data;
                return ListView.builder(
                  itemCount: topicByUserList?.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> topicByUserMap =
                        topicByUserList![index];
                    return grammarTopicView(context, topicByUserMap['image'],
                        topicByUserMap['name'], topicByUserMap['status'], () {
                      Get.to(() => QuestionTypeGScreen(
                          topicId: topicByUserMap['topicId']));
                    });
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const LoadingOverlay();
              }
            },
          ),
        ),
      )),
    );
  }
}
