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

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _formKey = GlobalKey<FormState>();
  final _courseController = TextEditingController();

  @override
  void dispose() {
    _courseController.dispose();
    super.dispose();
  }

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

              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _courseController,
                        decoration: const InputDecoration(
                          labelText: 'Nama Mata Kuliah',
                          hintText: 'Contoh: Pemrograman Mobile',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nama mata kuliah wajib diisi';
                          }

                          if (value.trim().length < 3) {
                            return 'Minimal 3 karakter';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Input diterima: '
                                  '${_courseController.text}',
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text('simpan'),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8),

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
