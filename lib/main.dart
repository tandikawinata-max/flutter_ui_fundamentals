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
      title: 'Passing Data Navigation',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CourseListPage(),
    );
  }
}

class CourseListPage extends StatelessWidget {
  const CourseListPage({super.key});

  static const String studentName = 'Tandika Winata';
  static const String studentId = '2415051080';

  @override
  Widget build(BuildContext context) {
    // Data list course
    final List<Map<String, dynamic>> courses = [
      {
        'title': 'Dart Fundamentals',
        'code': 'MOB01',
        'credits': '3 SKS',
        'status': 'Active',
        'description':
            'Mempelajari dasar-dasar bahasa pemrograman Dart untuk pengembangan Flutter.',
      },
      {
        'title': 'Flutter UI',
        'code': 'MOB02',
        'credits': '3 SKS',
        'status': 'Active',
        'description':
            'Membangun antarmuka pengguna yang menarik menggunakan widget dasar Flutter.',
      },
      {
        'title': 'Responsive Layout',
        'code': 'MOB04',
        'credits': '4 SKS',
        'status': 'Active',
        'description':
            'Membuat UI Flutter yang adaptif terhadap berbagai ukuran layar.',
      },
      {
        'title': 'Navigation & Interaction',
        'code': 'MOB05',
        'credits': '3 SKS',
        'status': 'Planned',
        'description':
            'Mengelola navigasi multi-screen dan menangani interaksi pengguna.',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Course List')),
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
              'Pilih salah satu course untuk melihat detail:',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            const SizedBox(height: 12),

            // Daftar course menggunakan ListView.builder
            Expanded(
              child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(
                        course['title']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${course['code']} • ${course['credits']}',
                      ),
                      trailing: Text(
                        course['status']!,
                        style: TextStyle(
                          color: course['status'] == 'Active'
                              ? Colors.green
                              : Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        // Mengirim data Map course melalui constructor ke CourseDetailPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CourseDetailPage(course: course),
                          ),
                        );
                      },
                    ),
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

class CourseDetailPage extends StatelessWidget {
  final Map<String, dynamic> course;

  // Constructor untuk menerima data course dari halaman sebelumnya
  const CourseDetailPage({super.key, required this.course});

  static const String studentName = 'Tandika Winata';
  static const String studentId = '2415051080';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(course['title']!)),
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

            // Menampilkan data yang dikirim melalui constructor
            Text(
              course['title']!,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Kode Mata Kuliah: ${course['code']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Bobot SKS: ${course['credits']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${course['status']}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: course['status'] == 'Active'
                    ? Colors.green
                    : Colors.orange,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Deskripsi:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              course['description']!,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
