import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course_provider.dart';

const String studentName = 'Tandika Winata';
const String studentId = '2415051080';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();

    final bool favorite = provider.isFavorite(course.code);

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Course')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '$studentId - $studentName',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 24),

            Text(
              course.title,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Kode: ${course.code}'),
                    const SizedBox(height: 8),

                    Text('SKS: ${course.credits}'),
                    const SizedBox(height: 8),

                    Text('Status: ${course.status}'),
                    const SizedBox(height: 16),

                    Text(
                      favorite ? 'Favorite: Ya' : 'Favorite: Tidak',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<CourseProvider>().toggleFavorite(course.code);
                },
                icon: Icon(favorite ? Icons.favorite : Icons.favorite_border),
                label: Text(
                  favorite ? 'Hapus dari Favorite' : 'Tambah ke Favorite',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
