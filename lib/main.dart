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
      title: 'LayoutBuilder Breakpoint',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const BreakpointPage(),
    );
  }
}

class BreakpointPage extends StatelessWidget {
  const BreakpointPage({super.key});

  static const String studentName = 'Tandika Winata';
  static const String studentId = '2415051080';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 3: LayoutBuilder & Breakpoint')),
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

            // Menggunakan LayoutBuilder untuk mendeteksi ruang lokal dan breakpoint
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 600) {
                    return const CompactLayout();
                  } else if (constraints.maxWidth < 840) {
                    return const MediumLayout();
                  } else {
                    return const ExpandedLayout();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget untuk Kategori Compact (< 600 px)
class CompactLayout extends StatelessWidget {
  const CompactLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.red.shade100,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.phone, size: 48, color: Colors.red),
          SizedBox(height: 8),
          Text(
            'Compact Layout (< 600 px)\nTampilan untuk Smartphone',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

// Widget untuk Kategori Medium (600 - 839 px)
class MediumLayout extends StatelessWidget {
  const MediumLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.orange.shade100,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.tablet, size: 48, color: Colors.orange),
          SizedBox(height: 8),
          Text(
            'Medium Layout (600 - 839 px)\nTampilan untuk Small Tablet / Tablet Portrait',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}

// Widget untuk Kategori Expanded (>= 840 px)
class ExpandedLayout extends StatelessWidget {
  const ExpandedLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.green.shade100,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.desktop_mac, size: 48, color: Colors.green),
          SizedBox(height: 8),
          Text(
            'Expanded Layout (>= 840 px)\nTampilan untuk Tablet Landscape / Laptop / Desktop',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
