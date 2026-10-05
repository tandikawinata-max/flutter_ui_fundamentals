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
      title: 'Responsive GridView',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ResponsiveGridPage(),
    );
  }
}

class ResponsiveGridPage extends StatelessWidget {
  const ResponsiveGridPage({super.key});

  static const String studentName = 'Tandika Winata';
  static const String studentId = '2415051080';

  // Menentukan jumlah kolom berdasarkan lebar layar (breakpoint)
  int _columnsFor(double width) {
    if (width < 600) return 1; // Compact (Smartphone)
    if (width < 840) return 2; // Medium (Tablet Portrait)
    return 3; // Expanded (Tablet Landscape / Desktop)
  }

  @override
  Widget build(BuildContext context) {
    // Data dummy course (menggunakan collection / data dari pertemuan sebelumnya)
    final List<Map<String, dynamic>> courses = [
      {'title': 'Dart Fundamentals', 'code': 'MOB01', 'status': 'Active'},
      {'title': 'Flutter UI', 'code': 'MOB02', 'status': 'Active'},
      {'title': 'Responsive Layout', 'code': 'MOB04', 'status': 'Active'},
      {'title': 'Navigation', 'code': 'MOB05', 'status': 'Planned'},
      {'title': 'Interaction', 'code': 'MOB06', 'status': 'Planned'},
      {'title': 'State Management', 'code': 'MOB07', 'status': 'Planned'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 5: Responsive GridView')),
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

            // Menggunakan LayoutBuilder untuk mendapatkan lebar parent dan membuat GridView responsif
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final int crossAxisCount = _columnsFor(constraints.maxWidth);

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio:
                          2.5, // Rasio lebar dibanding tinggi card
                    ),
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      final course = courses[index];
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                course['title']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    course['code']!,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  Text(
                                    course['status']!,
                                    style: TextStyle(
                                      color: course['status'] == 'Active'
                                          ? Colors.green
                                          : Colors.orange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
