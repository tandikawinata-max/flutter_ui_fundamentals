import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course_provider.dart';
import '../widgets/course_card.dart';
import 'favorites_screen.dart';

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

          Row(
            children: [
              const Expanded(
                child: Text(
                  'Daftar Course',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),

              IconButton(
                tooltip: 'Favorites',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FavoritesScreen()),
                  );
                },

                icon: Badge(
                  label: Text('${provider.favoriteCount}'),
                  child: const Icon(Icons.favorite),
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          const Text('Shared Favorite State'),

          const SizedBox(height: 20),

          Expanded(child: _buildContent(context, provider)),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, CourseProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Gagal memuat data'),

            const SizedBox(height: 12),

            Text(provider.error!),

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

                child: Text(
                  'Total Favorite: '
                  '${provider.favoriteCount}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
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
