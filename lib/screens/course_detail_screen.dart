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

    final favorite = provider.isFavorite(course.code);

    return Scaffold(
      appBar: AppBar(title: const Text('Course Detail')),

      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),

          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('$studentId • $studentName'),

                const SizedBox(height: 24),

                Container(
                  padding: const EdgeInsets.all(24),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.menu_book_rounded, size: 40),

                      const SizedBox(height: 18),

                      Text(
                        course.title,
                        style: const TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(course.code),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _DetailRow(label: 'Code', value: course.code),

                        const Divider(),

                        _DetailRow(
                          label: 'Credits',
                          value: '${course.credits} SKS',
                        ),

                        const Divider(),

                        _DetailRow(label: 'Status', value: course.status),

                        const Divider(),

                        _DetailRow(
                          label: 'Favorite',
                          value: favorite ? 'Yes' : 'No',
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      context.read<CourseProvider>().toggleFavorite(
                        course.code,
                      );
                    },
                    icon: Icon(
                      favorite ? Icons.favorite : Icons.favorite_border,
                    ),
                    label: Text(
                      favorite ? 'Remove Favorite' : 'Add to Favorites',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
