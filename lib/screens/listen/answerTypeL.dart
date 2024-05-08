import 'package:flutter/material.dart';

class AnswerTypeL extends StatefulWidget {
  final String answer;
  final Function(List<String>) onInputValuesChanged;
  final Color color;

  AnswerTypeL(
      {required this.answer,
      required this.onInputValuesChanged,
      required this.color});

  @override
  _AnswerTypeLState createState() => _AnswerTypeLState();
}

class _AnswerTypeLState extends State<AnswerTypeL> {
  late List<String> _inputList;
  late List<FocusNode> _focusNodes;
  late List<String> _inputValues;

  @override
  void initState() {
    super.initState();
    _inputList = widget.answer.split('');

    _focusNodes = List.generate(
      _inputList.length,
      (index) => FocusNode(),
    );

    _inputValues = List.generate(
      _inputList.length,
      (index) => '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20.0,
      runSpacing: 20.0,
      children: _inputList.asMap().entries.map((entry) {
        final index = entry.key;
        final input = entry.value;
        return SizedBox(
          width: 40.0,
          height: 40.0,
          child: TextField(
            maxLength: 1,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(fontSize: 24.0, color: widget.color),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(6.0),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.color),
              ),
              counterText: '',
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                _inputValues[index] = value;
                widget.onInputValuesChanged(_inputValues);
                // chuyển focus sang ô input tiếp theo
                if (index < _focusNodes.length - 1) {
                  _focusNodes[index + 1].requestFocus();
                }
              }
            },
            focusNode: _focusNodes[index],
          ),
        );
      }).toList(),
    );
  }
}
