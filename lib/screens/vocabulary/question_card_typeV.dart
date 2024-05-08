import 'package:english_app/controllers/vocabulary_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:english_app/models/vocabulary_model.dart';

import 'answer_typeV.dart';

class QuestionCardTypeV extends StatefulWidget {
  const QuestionCardTypeV({Key? key, required this.data}) : super(key: key);

  final VocabularyModel data;

  @override
  State<QuestionCardTypeV> createState() => _QuestionCardTypeVState();
}

class _QuestionCardTypeVState extends State<QuestionCardTypeV> {
  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    VocabularyController _controller = Get.put(VocabularyController());

    var options = [
      widget.data.answerA,
      widget.data.answerB,
      widget.data.answerC,
      widget.data.answerD
    ];

    // print(widget.data.id);

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25.0)),
      child: Column(
        children: [
          Image.network(
            widget.data.questionImg,
            height: 180,
            width: 300,
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: 20,
          ),

          ...List.generate(
              options.length,
              (index) => AnswerTypeV(
                  answerOption: options[index],
                  index: index,
                  onTap: () => !_controller.isAnswered
                      ? _controller.checkAns(widget.data, index)
                      : null))
        ],
      ),
    );
  }
}
