import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course_provider.dart';
import '../widgets/course_card.dart';

const String studentName = 'Tandika Winata';
const String studentId = '2415051080';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();

    final List<Course> favoriteCourses = provider.favoriteCourses;

    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Courses')),

      body: Padding(
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
              'Total Favorite: ${favoriteCourses.length}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: favoriteCourses.isEmpty
                  ? const Center(child: Text('Belum ada course favorite.'))
                  : ListView.builder(
                      itemCount: favoriteCourses.length,

                      itemBuilder: (context, index) {
                        final course = favoriteCourses[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: CourseCard(course: course),
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
