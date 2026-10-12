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
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Courses',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          const Text('$studentId • $studentName'),

          const SizedBox(height: 8),

          Text(
            '${provider.courses.length} courses available',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 24),

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
            Text('Loading courses...'),
          ],
        ),
      );
    }

    if (provider.error != null) {
      return Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline_rounded, size: 48),

                const SizedBox(height: 16),

                const Text(
                  'Unable to load courses',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                Text(provider.error!, textAlign: TextAlign.center),

                const SizedBox(height: 18),

                FilledButton.icon(
                  onPressed: () {
                    context.read<CourseProvider>().loadCourses();
                  },
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Try Again'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (provider.courses.isEmpty) {
      return const Center(child: Text('No course available.'));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 900) {
          return GridView.builder(
            itemCount: provider.courses.length,

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2.4,
            ),

            itemBuilder: (context, index) {
              final Course course = provider.courses[index];

              return CourseCard(course: course);
            },
          );
        }

        return ListView.separated(
          itemCount: provider.courses.length,

          separatorBuilder: (_, _) => const SizedBox(height: 12),

          itemBuilder: (context, index) {
            return CourseCard(course: provider.courses[index]);
          },
        );
      },
    );
  }
}
