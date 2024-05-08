import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_app/component/drawer.dart';
import 'package:english_app/component/loading_overlay.dart';
import 'package:english_app/screens/navigator_screen.dart';
import 'package:english_app/screens/vocabulary/question_typeV_screen.dart';
import 'package:english_app/screens/vocabulary/view_topic_typeV.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeTypeVScreen extends StatefulWidget {
  const HomeTypeVScreen({super.key});

  @override
  _HomeTypeVScreenState createState() => _HomeTypeVScreenState();
}

class _HomeTypeVScreenState extends State<HomeTypeVScreen> {
  Stream<List<Map<String, dynamic>>> topicByUser() {
    return FirebaseFirestore.instance
        .collectionGroup('vocabulary_topics')
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
            .where('typeId', isEqualTo: 1)
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
        } 
        else if(processQuerySnapshot.docs.isEmpty ) {

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
        title: const Text("Vocabulary"),
        backgroundColor: Colors.green,
          centerTitle: true,
        elevation: 0.0,
      ),
      drawer: const NavigatorDrawer(),
      body: SingleChildScrollView(
        child: Container(
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
                      Map<String, dynamic> topicByUserMap = topicByUserList![index];
                      return vocabularyTopicView(
                          context,
                          topicByUserMap['image'],
                          topicByUserMap['name'],
                          topicByUserMap['status'],
                          () {
                            print("Go to QuestionScreen");
                            Get.to(() => QuestionTypeVScreen(topicId: topicByUserMap['topicId']));
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
        ),
      ),
    );
  }
}