import 'package:flutter/material.dart';

const String studentName = 'Tandika Winata';
const String studentId = '2415051080';

const List<Map<String, dynamic>> topics = [
  {'title': 'Git & GitHub', 'subtitle': 'Version control', 'done': true},
  {'title': 'Dart Fundamentals', 'subtitle': 'Language basics', 'done': true},
  {
    'title': 'Flutter UI Fundamentals',
    'subtitle': 'Widgets & layout',
    'done': false,
  },
  {
    'title': '$studentId - $studentName',
    'subtitle': 'Pemilik aplikasi',
    'done': false,
  },
];

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

  int get completed => topics.where((item) => item['done'] == true).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learning Dashboard')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              '$studentId - $studentName\n'
              '$completed dari ${topics.length} topik selesai',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: topics.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final item = topics[index];
                return buildTopicCard(item);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTopicCard(Map<String, dynamic> item) {
    final isDone = item['done'] == true;

    return Card(
      child: ListTile(
        leading: Icon(
          isDone ? Icons.check_circle : Icons.schedule,
          color: isDone ? Colors.green : Colors.orange,
        ),
        title: Text(item['title'] as String),
        subtitle: Text(item['subtitle'] as String),
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
