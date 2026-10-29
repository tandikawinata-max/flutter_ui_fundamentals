import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/course_provider.dart';
import 'repositories/course_repository.dart';
import 'screens/main_dashboard.dart';
import 'services/course_api.dart';

const String studentName = 'Tandika Winata';
const String studentId = '2415051080';

const String apiBaseUrl = 'https://course-api-pearl.vercel.app';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // REST API sebagai data source saat ini.
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
