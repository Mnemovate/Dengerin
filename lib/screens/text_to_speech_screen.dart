import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechScreen extends StatefulWidget {
  const TextToSpeechScreen({super.key});

  @override
  State<TextToSpeechScreen> createState() => _TextToSpeechScreenState();
}

class _TextToSpeechScreenState extends State<TextToSpeechScreen> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textEditingController = TextEditingController();
  double _volume = 1.0;
  double _pitch = 1.0;
  double _rate = 0.5;
  bool _isSpeaking = false;

  @override
  void initState() {
    super.initState();
    initTts();
  }

  void initTts() {
    flutterTts.setStartHandler(() {
      setState(() {
        _isSpeaking = true;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        _isSpeaking = false;
      });
    });

    flutterTts.setErrorHandler((message) {
      setState(() {
        _isSpeaking = false;
      });
    });
  }

  Future<void> speak() async {
    if (textEditingController.text.isNotEmpty) {
      await flutterTts.setVolume(_volume);
      await flutterTts.setPitch(_pitch);
      await flutterTts.setSpeechRate(_rate);
      await flutterTts.speak(textEditingController.text);
    }
  }

  Future<void> stop() async {
    await flutterTts.stop();
    setState(() {
      _isSpeaking = false;
    });
  }

  @override
  void dispose() {
    flutterTts.stop();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dengerin'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: textEditingController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Masukkan teks disini...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Volume', style: TextStyle(fontWeight: FontWeight.bold)),
            Slider(
              value: _volume,
              min: 0.0,
              max: 1.0,
              divisions: 10,
              label: _volume.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  _volume = value;
                });
              },
            ),
            const Text('Pitch', style: TextStyle(fontWeight: FontWeight.bold)),
            Slider(
              value: _pitch,
              min: 0.5,
              max: 2.0,
              divisions: 15,
              label: _pitch.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  _pitch = value;
                });
              },
            ),
            const Text('Kecepatan', style: TextStyle(fontWeight: FontWeight.bold)),
            Slider(
              value: _rate,
              min: 0.0,
              max: 1.0,
              divisions: 10,
              label: _rate.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  _rate = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _isSpeaking ? null : speak,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Putar'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _isSpeaking ? stop : null,
                  icon: const Icon(Icons.stop),
                  label: const Text('Berhenti'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}