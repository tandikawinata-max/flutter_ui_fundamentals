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
      title: 'Navigation Basic',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String studentName = 'Tandika Winata';
  static const String studentId = '2415051080';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Padding(
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
              'Ini adalah halaman utama (Home). Tekan tombol di bawah untuk berpindah ke halaman detail.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // Tombol untuk melakukan Navigator.push ke DetailPage
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DetailPage()),
                );
              },
              child: const Text('Buka Detail Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  static const String studentName = 'Tandika Winata';
  static const String studentId = '2415051080';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Page')),
      body: Padding(
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
              'Selamat datang di Halaman Detail!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Tombol untuk melakukan Navigator.pop kembali ke HomePage
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade100,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Kembali dengan Navigator.pop()'),
            ),
          ],
        ),
      ),
    );
  }
}
