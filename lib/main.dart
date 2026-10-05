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
      title: 'Scrollable Content & Keyboard',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ScrollableFormPage(),
    );
  }
}

class ScrollableFormPage extends StatelessWidget {
  const ScrollableFormPage({super.key});

  static const String studentName = 'Tandika Winata';
  static const String studentId = '2415051080';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 6: Scrollable & Keyboard')),
      // SingleChildScrollView mencegah bottom overflow saat keyboard virtual muncul
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

            const Text(
              'Form Profil / Komentar Mahasiswa',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            TextField(
              decoration: InputDecoration(
                labelText: 'Nama Lengkap',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              decoration: InputDecoration(
                labelText: 'NIM',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Kesan Mengikuti Praktikum Flutter',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Simpan Data'),
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
