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
      title: 'Returning Data Navigation',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CourseListPage(),
    );
  }
}

class CourseListPage extends StatefulWidget {
  const CourseListPage({super.key});

  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  static const String studentName = 'Tandika Winata';
  static const String studentId = '2415051080';

  final List<Map<String, dynamic>> courses = [
    {
      'title': 'Dart Fundamentals',
      'code': 'MOB01',
      'status': 'Active',
      'isFavorite': false,
    },
    {
      'title': 'Flutter UI',
      'code': 'MOB02',
      'status': 'Active',
      'isFavorite': false,
    },
    {
      'title': 'Responsive Layout',
      'code': 'MOB04',
      'status': 'Active',
      'isFavorite': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Course List & Return Data')),
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
              'Tekan course untuk ubah status favorite dan kembalikan data:',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];
                  return Card(
                    child: ListTile(
                      title: Text(course['title']),
                      subtitle: Text(course['code']),
                      trailing: Icon(
                        course['isFavorite']
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: course['isFavorite'] ? Colors.red : Colors.grey,
                      ),
                      onTap: () async {
                        // Membuka halaman detail dan menunggu hasil kembalian (returning data)
                        final result = await Navigator.push<bool>(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CourseDetailPage(course: course),
                          ),
                        );

                        // Jika halaman detail mengembalikan nilai true (dijadikan favorite)
                        if (result == true) {
                          setState(() {
                            courses[index]['isFavorite'] =
                                !courses[index]['isFavorite'];
                          });

                          // Menampilkan SnackBar sebagai feedback
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Status favorite "${course['title']}" diperbarui!',
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
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

  const CourseDetailPage({super.key, required this.course});

  static const String studentName = 'Tandika Winata';
  static const String studentId = '2415051080';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(course['title'])),
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
            Text(
              'Course: ${course['title']}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Klik tombol di bawah untuk mengubah status favorite dan kembali ke halaman sebelumnya:',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade100,
              ),
              onPressed: () {
                // Mengembalikan nilai true ke halaman sebelumnya menggunakan Navigator.pop
                Navigator.pop(context, true);
              },
              icon: const Icon(Icons.favorite, color: Colors.red),
              label: const Text('Toggle Favorite & Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}
