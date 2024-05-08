import 'package:flutter/material.dart';

class AnswerTypeG extends StatefulWidget {
  const AnswerTypeG(
      {Key? key, required this.wordList, required this.onAnswerValuesChanged, required this.color})
      : super(key: key);

  final List<String> wordList;
  final Function(List<String>) onAnswerValuesChanged;
  final Color color;

  @override
  _AnswerTypeGState createState() => _AnswerTypeGState();
}

class _AnswerTypeGState extends State<AnswerTypeG> {
  List<String> yourAnswer = [];

  void addToYourAnswer(String word) {
    setState(() {
      yourAnswer.add(word);
      widget.wordList.remove(word);
      widget.onAnswerValuesChanged(yourAnswer);
    });
  }

  void removeFromYourAnswer(String word) {
    setState(() {
      yourAnswer.remove(word);
      widget.wordList.add(word);
      widget.onAnswerValuesChanged(yourAnswer);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          width: MediaQuery.of(context).size.width,
          child: Text('Your Answer',
              style: TextStyle(fontWeight: FontWeight.bold, color: widget.color)),
        ),
        Container(
          constraints: const BoxConstraints(minHeight: 100.0),
          child: Wrap(
            spacing: 12.0,
            runSpacing: 0.0,
            children: yourAnswer
                .map(
                  (word) => ActionChip(
                    label: Text(word, style: TextStyle(color: widget.color)),
                    backgroundColor: Colors.blueGrey[100],
                    onPressed: () => {removeFromYourAnswer(word)},
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: const Text('Word List',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Container(
          constraints: const BoxConstraints(minHeight: 100.0),
          child: Wrap(
            spacing: 12.0,
            runSpacing: 0.0,
            children: widget.wordList
                .map(
                  (word) => ActionChip(
                    label: Text(word),
                    backgroundColor: Colors.blueGrey[100],
                    onPressed: () => addToYourAnswer(word),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
