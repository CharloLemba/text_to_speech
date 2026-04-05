import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

// Entry point aplikasi
void main() {
  runApp(const MyApp());
}

// Root widget aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TtsPage(), // Halaman utama
      debugShowCheckedModeBanner: false, // Hilangkan banner debug
    );
  }
}

// StatefulWidget karena kita butuh state (text, bahasa, dll)
class TtsPage extends StatefulWidget {
  const TtsPage({super.key});

  @override
  State<TtsPage> createState() => _TtsPageState();
}

class _TtsPageState extends State<TtsPage> {
  // Instance TTS
  final FlutterTts flutterTts = FlutterTts();

  // Controller untuk mengambil text dari TextField
  final TextEditingController controller = TextEditingController();

  // Bahasa default
  String selectedLanguage = "en-US";

  // List bahasa sederhana
  final List<String> languages = ["en-US", "id-ID"];

  // Fungsi untuk mulai bicara
  Future<void> speak() async {
    await flutterTts.setLanguage(selectedLanguage); // set bahasa
    await flutterTts.speak(controller.text); // ambil text dari input
  }

  // Pause suara
  Future<void> pause() async {
    await flutterTts.pause();
  }

  // Stop suara
  Future<void> stop() async {
    await flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar di atas
      appBar: AppBar(title: const Text("Simple TTS")),

      // Body utama
      body: Padding(
        padding: const EdgeInsets.all(16), // kasih jarak semua sisi
        child: Column(
          children: [
            // Label
            const Text("Masukkan teks:", style: TextStyle(fontSize: 18)),

            const SizedBox(height: 10), // jarak
            // 🔥 TEXT AREA (multi-line)
            TextField(
              controller: controller, // koneksi ke controller

              maxLines: 5, // 👉 bikin jadi multi-line (text area)
              minLines: 3, // minimal tinggi awal

              decoration: const InputDecoration(
                border: OutlineInputBorder(), // border kotak
                hintText: "Tulis sesuatu lebih dari satu baris...",
              ),
            ),

            const SizedBox(height: 20),

            // Dropdown pilih bahasa
            DropdownButton<String>(
              value: selectedLanguage,
              isExpanded: true, // biar full width
              // Generate item dari list languages
              items: languages.map((lang) {
                return DropdownMenuItem(value: lang, child: Text(lang));
              }).toList(),

              // Ketika user ganti bahasa
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!; // update state
                });
              },
            ),

            const SizedBox(height: 20),

            // Tombol-tombol kontrol
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Tombol play
                ElevatedButton(onPressed: speak, child: const Text("Play")),

                // Tombol pause
                ElevatedButton(onPressed: pause, child: const Text("Pause")),

                // Tombol stop
                ElevatedButton(onPressed: stop, child: const Text("Stop")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
