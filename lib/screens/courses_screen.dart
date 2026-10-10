import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course_provider.dart';
import '../widgets/course_card.dart';

const String studentName = 'Tandika Winata';
const String studentId = '2415051080';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '$studentId - $studentName',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 24),

          const Text(
            'Daftar Course',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 4),

          const Text('Provider → Repository → Service'),

          const SizedBox(height: 20),

          Expanded(child: _buildContent(context, provider)),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, CourseProvider provider) {
    if (provider.isLoading) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Memuat data course...'),
          ],
        ),
      );
    }

    if (provider.error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48),

            const SizedBox(height: 12),

            const Text(
              'Gagal memuat data',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(provider.error!, textAlign: TextAlign.center),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                context.read<CourseProvider>().loadCourses();
              },
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      );
    }

    if (provider.courses.isEmpty) {
      return const Center(child: Text('Data course tidak tersedia.'));
    }

    return ListView.builder(
      itemCount: provider.courses.length + 1,
      itemBuilder: (context, index) {
        if (index == provider.courses.length) {
          return Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 20),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.favorite),

                    const SizedBox(width: 12),

                    Text(
                      'Total Favorite: '
                      '${provider.favoriteCount}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        final Course course = provider.courses[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: CourseCard(course: course),
        );
      },
    );
  }
}
