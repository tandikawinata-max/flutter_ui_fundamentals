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
      title: 'Responsive Layout Practice',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ResponsiveProblemPage(),
    );
  }
}

class ResponsiveProblemPage extends StatelessWidget {
  const ResponsiveProblemPage({super.key});

  static const String studentName = 'Tandika Winata';
  static const String studentId = '2415051080';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 1: Responsive Problem')),
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
            const SizedBox(height: 16),

            // CONTOH 1: Masalah Ukuran Hard-coded (Lebar Tetap 500)
            // Ini akan menyebabkan overflow jika diuji pada layar smartphone yang lebih kecil dari 500px.
            const Text('1. Menggunakan Width Tetap (Hard-coded 500):'),
            const SizedBox(height: 8),
            Container(
              width: 500, // Coba amati apakah ini menyebabkan overflow di HP
              padding: const EdgeInsets.all(16),
              color: Colors.red.shade100,
              child: const Text(
                'Container dengan width: 500 (Potensi Overflow)',
                style: TextStyle(color: Colors.red),
              ),
            ),
            const SizedBox(height: 24),

            // CONTOH 2: Solusi Fleksibel (double.infinity atau Expanded)
            // Menggunakan width: double.infinity agar menyesuaikan lebar layar perangkat.
            const Text('2. Menggunakan Lebar Fleksibel (double.infinity):'),
            const SizedBox(height: 8),
            Container(
              width: double.infinity, // Solusi responsif
              padding: const EdgeInsets.all(16),
              color: Colors.green.shade100,
              child: const Text(
                'Container dengan width: double.infinity (Responsif)',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
