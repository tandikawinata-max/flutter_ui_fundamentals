import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

// ===============================
// IDENTITAS MAHASISWA
// ===============================
const String studentName = 'Tandika Winata';
const String studentId = '2415051080';

// ===============================
// LOAD DATA JSON
// ===============================
Future<Map<String, dynamic>> loadStudentData() async {
  final String jsonString = await rootBundle.loadString(
    'assets/data/student_data.json',
  );

  final Map<String, dynamic> data = jsonDecode(jsonString);

  return data;
}

// ===============================
// MAIN
// ===============================
void main() {
  runApp(const MyApp());
}

// ===============================
// MY APP
// ===============================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Debugging Challenge',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DashboardPage(),
    );
  }
}

// ===============================
// DASHBOARD PAGE
// ===============================
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<Map<String, dynamic>> studentFuture;

  @override
  void initState() {
    super.initState();

    studentFuture = loadStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learning Dashboard')),

      body: FutureBuilder<Map<String, dynamic>>(
        future: studentFuture,

        builder: (context, snapshot) {
          // ===============================
          // CASE C: LOADING
          // ===============================
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // ===============================
          // CASE C: ERROR
          // ===============================
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      'Gagal memuat data JSON',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text('${snapshot.error}', textAlign: TextAlign.center),
                  ],
                ),
              ),
            );
          }

          // ===============================
          // DATA BERHASIL
          // ===============================
          if (!snapshot.hasData) {
            return const Center(child: Text('Data tidak tersedia'));
          }

          final data = snapshot.data!;

          final String name = data['name'] ?? studentName;
          final String nim = data['nim'] ?? studentId;

          final List<dynamic> courses = data['courses'] ?? [];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // ===============================
                // IDENTITAS
                // ===============================
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),

                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 35,
                          child: Icon(Icons.person, size: 40),
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text('NIM: $nim'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // ===============================
                // SUMMARY
                // ===============================
                Row(
                  children: [
                    Expanded(
                      child: buildSummaryCard(
                        title: 'Mata Kuliah',
                        value: '${courses.length}',
                        icon: Icons.menu_book,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: buildSummaryCard(
                        title: 'Status',
                        value: 'Aktif',
                        icon: Icons.check_circle,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                const Text(
                  'Daftar Mata Kuliah',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                // ===============================
                // LIST COURSE
                // ===============================
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),

                  itemCount: courses.length,

                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 8);
                  },

                  itemBuilder: (context, index) {
                    final course = courses[index];

                    final String title = course['title'] ?? 'Tidak ada judul';

                    final String code = course['code'] ?? '-';

                    final String credits = '${course['credits'] ?? '-'} SKS';

                    final String status = course['status'] ?? 'Tidak diketahui';

                    return Card(
                      child: ListTile(
                        leading: const CircleAvatar(child: Icon(Icons.book)),

                        title: Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        subtitle: Text('$code • $credits'),

                        trailing: _buildStatus(status),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24),

                // ===============================
                // CASE A
                // RENDERFLEX OVERFLOW
                // ===============================
                const Text(
                  'Case A: RenderFlex Overflow',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),

                    child: Row(
                      children: [
                        const Icon(Icons.info),

                        const SizedBox(width: 10),

                        // Expanded digunakan untuk mencegah
                        // teks melebihi lebar layar.
                        Expanded(
                          child: Text(
                            'Ini adalah contoh teks yang cukup panjang '
                            'untuk menguji apakah Row mengalami '
                            'RenderFlex Overflow pada layar.',
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ===============================
                // CASE B
                // ASSET NOT FOUND
                // ===============================
                const Text(
                  'Case B: Asset',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Pastikan path asset, nama file, dan '
                  'pubspec.yaml sudah benar.',
                ),

                const SizedBox(height: 20),

                // ===============================
                // INFORMASI IDENTITAS
                // ===============================
                const Divider(),

                const SizedBox(height: 8),

                Text('Nama: $studentName'),

                Text('NIM: $studentId'),
              ],
            ),
          );
        },
      ),
    );
  }

  // ===============================
  // SUMMARY CARD
  // ===============================
  Widget buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            Icon(icon, size: 30),

            const SizedBox(height: 8),

            Text(
              value,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 4),

            Text(title),
          ],
        ),
      ),
    );
  }

  // ===============================
  // STATUS COURSE
  // ===============================
  Widget _buildStatus(String status) {
    if (status.toLowerCase() == 'selesai') {
      return const Icon(Icons.check_circle, color: Colors.green);
    }

    if (status.toLowerCase() == 'aktif') {
      return const Icon(Icons.play_circle, color: Colors.blue);
    }

    return const Icon(Icons.pending, color: Colors.orange);
  }
}
