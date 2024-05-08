import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_app/component/loading_overlay.dart';
import 'package:english_app/models/vocabulary_model.dart';
import 'package:english_app/screens/vocabulary/body_question_typeV_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/vocabulary_controller.dart';

class QuestionTypeVScreen extends StatefulWidget {
  const QuestionTypeVScreen({Key? key, required this.topicId}) : super(key: key);

  final int topicId;

  @override
  State<QuestionTypeVScreen> createState() => _QuestionTypeVScreenState();
}

class _QuestionTypeVScreenState extends State<QuestionTypeVScreen> {
  late Future<List<VocabularyModel>> _dataFuture;

  Future<List<VocabularyModel>> questionsByTopic() async {
    final snapshots = await FirebaseFirestore.instance
        .collectionGroup('vocabulary_quiz')
        .where('topicId', isEqualTo: widget.topicId)
        .get();
    final questions =
        snapshots.docs.map((e) => VocabularyModel.fromSnapshot(e)).toList();

    return questions;
  }

  @override
  void initState() {
    _dataFuture = questionsByTopic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    VocabularyController _controller = Get.put(VocabularyController());

    _controller.topicId = widget.topicId;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 24,
              color: Colors.white,
            ),
            onPressed: () {
              _controller.goToHome();
            },
          ),
          actions: [
            TextButton(
              onPressed: _controller.nextQuestion,
              child: const Text(
                "Skip",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: FutureBuilder(
          future: _dataFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingOverlay();
            }
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            final data = snapshot.requireData;

            _controller.questions = RxList(data);

            return BodyQuestionTypeVScreen();
          },
        ));
  }
}
