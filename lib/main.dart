import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'course_state.dart';

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
    final courseState = Provider.of<CourseState>(context);

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
            'Tahap 6',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 4),

          const Text(
            'Provider pada Widget Tree',
            style: TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 24),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Icon(Icons.favorite, size: 36),

                  const SizedBox(width: 16),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Jumlah Favorite',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '${courseState.favoriteCount}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            'CourseState sekarang disediakan menggunakan ChangeNotifierProvider.',
          ),
        ],
      ),
    );
  }
}

// ==================================================
// COURSES SCREEN
// ==================================================

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final courseState = Provider.of<CourseState>(context);

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

          const SizedBox(height: 16),

          CourseCard(
            code: 'IF001',
            title: 'Flutter State Management',
            courseState: courseState,
          ),

          const SizedBox(height: 12),

          CourseCard(
            code: 'IF002',
            title: 'Mobile Application Architecture',
            courseState: courseState,
          ),

          const SizedBox(height: 20),

          Text(
            'Total Favorite: ${courseState.favoriteCount}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
  final String code;
  final String title;
  final CourseState courseState;

  const CourseCard({
    super.key,
    required this.code,
    required this.title,
    required this.courseState,
  });

  @override
  Widget build(BuildContext context) {
    final bool favorite = courseState.isFavorite(code);

    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.school)),
        title: Text(title),
        subtitle: Text(code),
        trailing: IconButton(
          onPressed: () {
            courseState.toggleFavorite(code);
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
