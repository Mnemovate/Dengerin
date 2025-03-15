import 'package:dengerin/screens/text_to_speech_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Dengerin());
}

class Dengerin extends StatelessWidget {
  const Dengerin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const TextToSpeechScreen(),
    );
  }
}