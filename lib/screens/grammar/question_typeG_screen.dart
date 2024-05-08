import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_app/component/loading_overlay.dart';
import 'package:english_app/controllers/grammar_controller.dart';
import 'package:english_app/models/grammar_model.dart';
import 'package:english_app/screens/grammar/body_question_typeG_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class QuestionTypeGScreen extends StatefulWidget {
  const QuestionTypeGScreen({Key? key, required this.topicId}) : super(key: key);

  final int topicId;

  @override
  State<QuestionTypeGScreen> createState() => _QuestionTypeGScreenState();
}

class _QuestionTypeGScreenState extends State<QuestionTypeGScreen> {
  late Future<List<GrammarModel>> _dataFuture;

  Future<List<GrammarModel>> questionsByTopic() async {
    final snapshots = await FirebaseFirestore.instance
        .collectionGroup('grammar_quiz')
        .where('topicId', isEqualTo: widget.topicId)
        .get();
    final questions =
        snapshots.docs.map((e) => GrammarModel.fromSnapshot(e)).toList();

    return questions;
  }

  @override
  void initState() {
    _dataFuture = questionsByTopic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GrammarController _controller = Get.put(GrammarController());

    _controller.topicId = widget.topicId;

    return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
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
              return Text('Something went wrong');
            }

            final data = snapshot.requireData;

            _controller.questions = RxList(data);

            return BodyQuestionTypeGScreen();
          },
        ));
  }
}
