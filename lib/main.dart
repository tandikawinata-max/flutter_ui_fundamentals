import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'course_state.dart';
import 'models/course.dart';
import 'repositories/course_repository.dart';
import 'services/course_service.dart';

const String studentName = 'Tandika Winata';
const String studentId = '2415051080';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => CourseState(), child: const MyApp()),
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

// ==================================================
// MAIN DASHBOARD
// ==================================================

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeScreen(),
      const CoursesScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Course Explorer')),
      body: pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(Icons.school),
            label: 'Courses',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ==================================================
// HOME SCREEN
// ==================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final courseState = context.watch<CourseState>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '$studentId - $studentName',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 24),

          const Text(
            'Tahap 10',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 4),

          const Text('Repository Pattern', style: TextStyle(fontSize: 16)),

          const SizedBox(height: 24),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Icon(Icons.storage, size: 36),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Data Architecture',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 4),

                        const Text('UI → Repository → Service → JSON'),

                        const SizedBox(height: 12),

                        Text(
                          'Jumlah Favorite: '
                          '${courseState.favoriteCount}',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          const Text('Data course sekarang diakses melalui CourseRepository.'),
        ],
      ),
    );
  }
}

// ==================================================
// COURSES SCREEN
// ==================================================

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  // Service sebagai sumber data.
  final CourseService _courseService = CourseService();

  late final CourseRepository _courseRepository;

  late Future<List<Course>> _coursesFuture;

  @override
  void initState() {
    super.initState();

    // Dependency CourseService diberikan ke Repository.
    _courseRepository = CourseRepository(_courseService);

    // UI meminta data melalui Repository,
    // bukan langsung melalui CourseService.
    _coursesFuture = _courseRepository.getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '$studentId - $studentName',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 24),

          const Text(
            'Daftar Course',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 4),

          const Text('Data dimuat melalui Repository → Service'),

          const SizedBox(height: 16),

          FutureBuilder<List<Course>>(
            future: _coursesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Text('Terjadi error: ${snapshot.error}');
              }

              final List<Course> courses = snapshot.data ?? [];

              if (courses.isEmpty) {
                return const Text('Data course tidak tersedia.');
              }

              return Column(
                children: courses.map((course) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: CourseCard(course: course),
                  );
                }).toList(),
              );
            },
          ),

          const SizedBox(height: 12),

          Consumer<CourseState>(
            builder: (context, courseState, child) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.favorite),

                      const SizedBox(width: 12),

                      Text(
                        'Total Favorite: '
                        '${courseState.favoriteCount}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ==================================================
// COURSE CARD
// ==================================================

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final courseState = context.watch<CourseState>();

    final bool favorite = courseState.isFavorite(course.code);

    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.school)),

        title: Text(
          course.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kode: ${course.code}'),
            Text('SKS: ${course.credits}'),
            Text('Status: ${course.status}'),
          ],
        ),

        trailing: IconButton(
          onPressed: () {
            context.read<CourseState>().toggleFavorite(course.code);
          },
          icon: Icon(favorite ? Icons.favorite : Icons.favorite_border),
        ),
      ),
    );
  }
}

// ==================================================
// PROFILE SCREEN
// ==================================================

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$studentId - $studentName',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 24),

          Text(
            'Profile',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 12),

          Text('Nama : $studentName'),
          Text('NIM : $studentId'),
          Text('Kelas : PTI 5B'),
        ],
      ),
    );
  }
}
