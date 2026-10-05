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
      title: 'MediaQuery Practice',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MediaQueryPage(),
    );
  }
}

class MediaQueryPage extends StatelessWidget {
  const MediaQueryPage({super.key});

  // Identitas Mahasiswa sesuai ketentuan praktikum
  static const String studentName = 'Tandika Winata';
  static const String studentId = '2415051080';

  @override
  Widget build(BuildContext context) {
    // Membaca ukuran dan orientasi layar menggunakan MediaQuery
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    // Menentukan kategori breakpoint sederhana
    final layoutCategory = size.width < 600 ? 'Compact' : 'Wide';

    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 2: MediaQuery')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Identitas wajib di UI
            Text(
              '$studentId - $studentName',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 24),

            // Informasi dari MediaQuery
            Text(
              'Width: ${size.width.toStringAsFixed(0)} px',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Height: ${size.height.toStringAsFixed(0)} px',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Orientation: $orientation',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),

            // Indikator kategori layout
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.blue.shade100,
              child: Text(
                'Layout Category: $layoutCategory',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
