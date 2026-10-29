import 'package:flutter/material.dart';

import '../models/course.dart';
import '../services/course_api.dart';

class CourseApiTestScreen extends StatefulWidget {
  const CourseApiTestScreen({super.key});

  @override
  State<CourseApiTestScreen> createState() => _CourseApiTestScreenState();
}

class _CourseApiTestScreenState extends State<CourseApiTestScreen> {
  // REST API dari dosen
  final CourseApiService _service = CourseApiService(
    'https://course-api-pearl.vercel.app',
  );

  late Future<List<Course>> _coursesFuture;

  @override
  void initState() {
    super.initState();

    // Mengambil data ketika halaman pertama dibuka
    _coursesFuture = _service.getCourses();
  }

  // Memuat ulang data dari REST API
  void _refresh() {
    setState(() {
      _coursesFuture = _service.getCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 4 - Service Layer'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Identitas mahasiswa
            const Text(
              'Tandika Winata - 2415051080',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            const Text(
              'Data Course dari REST API Dosen',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 12),

            // Informasi endpoint
            const Text(
              'https://course-api-pearl.vercel.app/courses',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),

            const SizedBox(height: 16),

            // Data course dari service
            Expanded(
              child: FutureBuilder<List<Course>>(
                future: _coursesFuture,
                builder: (context, snapshot) {
                  // Loading
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Error
                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 48,
                          ),

                          const SizedBox(height: 12),

                          Text(
                            'Gagal mengambil data:\n${snapshot.error}',
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 16),

                          ElevatedButton.icon(
                            onPressed: _refresh,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  // Data berhasil diterima
                  final courses = snapshot.data ?? <Course>[];

                  // Empty state
                  if (courses.isEmpty) {
                    return const Center(
                      child: Text('Data course belum tersedia'),
                    );
                  }

                  // Menampilkan daftar course
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Jumlah course: ${courses.length}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),

                          IconButton(
                            onPressed: _refresh,
                            tooltip: 'Refresh Data',
                            icon: const Icon(Icons.refresh),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Expanded(
                        child: ListView.builder(
                          itemCount: courses.length,
                          itemBuilder: (context, index) {
                            final course = courses[index];

                            return Card(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                leading: CircleAvatar(
                                  child: Text('${course.id ?? "-"}'),
                                ),

                                title: Text(
                                  course.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                subtitle: Text(
                                  'Kode: ${course.code}\n'
                                  'SKS: ${course.credits}\n'
                                  'Status: ${course.status}',
                                ),

                                isThreeLine: true,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
