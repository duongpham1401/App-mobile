import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';

class TranslateScreen extends StatefulWidget {
  @override
  _TranslateScreenState createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  final TextEditingController _fromText = TextEditingController();
  final TextEditingController _toText = TextEditingController();
  String _fromLanguage = 'en';
  String _toLanguage = 'vi';

  final FlutterTts _flutterTts = FlutterTts();

  void _translate() async {
    final translator = GoogleTranslator();
    final translatedText = await translator.translate(_fromText.text,
        from: _fromLanguage, to: _toLanguage);
    setState(() {
      _toText.text = translatedText.toString();
    });
  }

  void _speak(bool translated) async {
    if (translated) {
      await _flutterTts.setLanguage(_toLanguage);
      await _flutterTts.speak(_toText.text);
    } else {
      await _flutterTts.setLanguage(_fromLanguage);
      await _flutterTts.speak(_fromText.text);
    }
  }

  @override
  void dispose() {
    _fromText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Translate"),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 120, 16, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.centerRight,
              children: [
                TextField(
                  controller: _fromText,
                  decoration: const InputDecoration(
                    labelText: 'From',
                    hintText: 'Enter text to translate',
                    border: OutlineInputBorder(),
                  ),
                ),
                Positioned(
                  right: 10.0,
                  child: GestureDetector(
                    onTap: () {
                      _speak(false);
                    },
                    child: Image.asset(
                      'assets/images/volume2.png',
                      width: 36.0,
                      height: 36.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                TextField(
                  controller: _toText,
                  decoration: const InputDecoration(
                    labelText: 'To',
                    hintText: 'Translation will appear here',
                    border: OutlineInputBorder(),
                  ),
                ),
                Positioned(
                  right: 10.0,
                  child: GestureDetector(
                    onTap: () {
                      _speak(true);
                    },
                    child: Image.asset(
                      'assets/images/volume.jpg',
                      width: 40.0,
                      height: 40.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _fromLanguage,
                    onChanged: (value) {
                      setState(() {
                        _fromLanguage = value!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'From',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'en',
                        child: Text('English'),
                      ),
                      DropdownMenuItem(
                        value: 'vi',
                        child: Text('Vietnamese'),
                      ),
                      DropdownMenuItem(
                        value: 'fr',
                        child: Text('French'),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _toLanguage,
                    onChanged: (value) {
                      setState(() {
                        _toLanguage = value!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'To',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'en',
                        child: Text('English'),
                      ),
                      DropdownMenuItem(
                        value: 'vi',
                        child: Text('Vietnamese'),
                      ),
                      DropdownMenuItem(
                        value: 'fr',
                        child: Text('French'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: _translate,
                  child: Text('Translate'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
