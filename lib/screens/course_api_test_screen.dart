import 'package:flutter/material.dart';

import '../models/course.dart';
import '../services/course_api.dart';

class CourseApiTestScreen extends StatefulWidget {
  const CourseApiTestScreen({super.key});

  @override
  State<CourseApiTestScreen> createState() => _CourseApiTestScreenState();
}

class _CourseApiTestScreenState extends State<CourseApiTestScreen> {
  late Future<List<Course>> _coursesFuture;

  @override
  void initState() {
    super.initState();
    _coursesFuture = fetchCoursesTest();
  }

  void _refresh() {
    setState(() {
      _coursesFuture = fetchCoursesTest();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 3 - Model Dart')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tandika Winata - 2415051080',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text('Data Course dari REST API Dosen'),
            const SizedBox(height: 12),
            Expanded(
              child: FutureBuilder<List<Course>>(
                future: _coursesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Error: ${snapshot.error}'),
                          ElevatedButton(
                            onPressed: _refresh,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  final courses = snapshot.data ?? <Course>[];

                  if (courses.isEmpty) {
                    return const Center(child: Text('Data course kosong'));
                  }

                  return ListView.builder(
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      final course = courses[index];

                      return Card(
                        child: ListTile(
                          title: Text(course.title),
                          subtitle: Text(
                            'Kode: ${course.code}\n'
                            'SKS: ${course.credits}\n'
                            'Status: ${course.status}',
                          ),
                          trailing: Text('ID: ${course.id ?? "-"}'),
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
