import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/course_provider.dart';
import 'repositories/course_repository.dart';
import 'screens/main_dashboard.dart';
import 'services/course_service.dart';

void main() {
  final CourseService service = CourseService();

  final CourseRepository repository = CourseRepository(service);

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

      title: 'Course Explorer',

      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),

      home: const MainDashboard(),
    );
  }
}
