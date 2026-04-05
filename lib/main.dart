import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TtsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TtsPage extends StatefulWidget {
  const TtsPage({super.key});

  @override
  State<TtsPage> createState() => _TtsPageState();
}

class _TtsPageState extends State<TtsPage> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController controller = TextEditingController();

  String selectedLanguage = "en-US";

  final List<String> languages = ["en-US", "id-ID"];

  Future<void> speak() async {
    await flutterTts.setLanguage(selectedLanguage);
    await flutterTts.speak(controller.text);
  }

  Future<void> pause() async {
    await flutterTts.pause();
  }

  Future<void> stop() async {
    await flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Simple TTS")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Masukkan teks:", style: TextStyle(fontSize: 18)),

            const SizedBox(height: 10),

            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Tulis sesuatu...",
              ),
            ),

            const SizedBox(height: 20),

            DropdownButton<String>(
              value: selectedLanguage,
              isExpanded: true,
              items: languages.map((lang) {
                return DropdownMenuItem(value: lang, child: Text(lang));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: speak, child: const Text("Play")),
                ElevatedButton(onPressed: pause, child: const Text("Pause")),
                ElevatedButton(onPressed: stop, child: const Text("Stop")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
