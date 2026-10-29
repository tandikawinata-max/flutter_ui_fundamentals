import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'providers/course_provider.dart';
import 'repositories/course_repository.dart';
import 'screens/main_dashboard.dart';
import 'services/course_api.dart';

// Identitas mahasiswa
const String studentName = 'Tandika Winata';
const String studentId = '2415051080';

// REST API dosen: tetap digunakan pada Tahap 10
const String apiBaseUrl = 'https://course-api-pearl.vercel.app';

// Konfigurasi Supabase melalui --dart-define
const String supabaseUrl = String.fromEnvironment('SUPABASE_URL');

const String supabaseAnonKey = String.fromEnvironment(
  'SUPABASE_PUBLISHABLE_KEY',
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Validasi konfigurasi sebelum inisialisasi.
  if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) {
    throw StateError(
      'Konfigurasi Supabase belum tersedia. '
      'Jalankan aplikasi dengan SUPABASE_URL '
      'dan SUPABASE_PUBLISHABLE_KEY.',
    );
  }

  // TAHAP 10: Inisialisasi Supabase
  await Supabase.initialize(url: supabaseUrl, publishableKey: supabaseAnonKey);

  debugPrint('Supabase client berhasil diinisialisasi');

  debugPrint('Mahasiswa: $studentName ($studentId)');

  // TAHAP 9:
  // Sumber data utama masih REST API dosen.
  final repository = CourseRepository(CourseApiService(apiBaseUrl));

  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseProvider(repository)..loadCourses(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer v2',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)),
      ),
      home: const MainDashboard(),
    );
  }
}
