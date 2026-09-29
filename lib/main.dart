import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

const String studentName = 'Tandika Winata';
const String studentId = '2415051080';

Future<Map<String, dynamic>> loadStudentData() async {
  final jsonString = await rootBundle.loadString(
    'assets/data/student_data.json',
  );

  return jsonDecode(jsonString) as Map<String, dynamic>;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learning Dashboard')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: loadStudentData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Terjadi kesalahan: ${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Data tidak tersedia'));
          }

          final data = snapshot.data!;
          final student = data['student'] as Map<String, dynamic>;
          final courses = data['courses'] as List<dynamic>;

          final nim = student['nim'] as String;
          final name = student['name'] as String;

          final completed = courses
              .where((course) => course['status'] == 'done')
              .length;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '$nim - $name\n'
                  '$completed dari ${courses.length} topik selesai',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: courses.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final course = courses[index] as Map<String, dynamic>;

                    return buildCourseCard(course);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildCourseCard(Map<String, dynamic> course) {
    final isDone = course['status'] == 'done';

    return Card(
      child: ListTile(
        leading: Icon(
          isDone ? Icons.check_circle : Icons.schedule,
          color: isDone ? Colors.green : Colors.orange,
        ),
        title: Text(course['title'] as String),
        subtitle: Text('${course['code']} • ${course['credits']} SKS'),
        trailing: Text(
          isDone ? 'Selesai' : 'Belum',
          style: TextStyle(
            color: isDone ? Colors.green : Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
