import 'package:flutter/material.dart';

const String studentName = 'Tandika Winata';
const String studentId = '2415051080';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter UI Fundamentals')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Menggunakan CircleAvatar dengan file foto dari asset
                const CircleAvatar(
                  radius: 46,
                  backgroundImage: AssetImage(
                    'assets/images/TAN_GANTENG_BANGET.jpeg',
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '$studentId - $studentName',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tertarik mendalami pengembangan aplikasi mobile lintas platform.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Belajar Widget Tree',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 12),
                const Icon(Icons.widgets, size: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
