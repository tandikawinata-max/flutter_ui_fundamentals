import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expanded, Flexible, Wrap',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const FlexWrapPage(),
    );
  }
}

class FlexWrapPage extends StatelessWidget {
  const FlexWrapPage({super.key});

  static const String studentName = 'Tandika Winata';
  static const String studentId = '2415051080';

  @override
  Widget build(BuildContext context) {
    // Daftar skill untuk contoh Wrap / Chip
    final List<String> skills = [
      'Flutter',
      'Dart',
      'Responsive Layout',
      'UI/UX Design',
      'Mobile Development',
      'State Management',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 4: Expanded, Flexible, Wrap')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Identitas Mahasiswa wajib di UI
            const Text(
              '$studentId - $studentName',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 24),

            // Bagian 1: Expanded dalam Row (Perbandingan flex 2:1)
            const Text(
              '1. Expanded Widget (Perbandingan Flex 2 : 1):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 80,
                    color: Colors.blue.shade300,
                    alignment: Alignment.center,
                    child: const Text(
                      'Flex 2 (A)',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 80,
                    color: Colors.orange.shade300,
                    alignment: Alignment.center,
                    child: const Text(
                      'Flex 1 (B)',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Bagian 2: Wrap Widget untuk Chip
            const Text(
              '2. Wrap Widget untuk Kumpulan Chip:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Wrap(
                spacing: 8.0, // Jarak horizontal antar chip
                runSpacing: 4.0, // Jarak vertikal antar baris chip
                children: skills
                    .map(
                      (skill) => Chip(
                        label: Text(skill),
                        backgroundColor: Colors.blue.shade50,
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
