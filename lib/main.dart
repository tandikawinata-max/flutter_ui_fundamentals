import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BottomNavigationBar Practice',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainNavigationPage(),
    );
  }
}

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  // Indeks halaman yang sedang aktif
  int _currentIndex = 0;

  static const String studentName = 'Tandika Winata';
  static const String studentId = '2415051080';

  // Daftar halaman yang akan ditampilkan berdasarkan tab
  final List<Widget> _pages = [
    const HomeScreen(),
    const CoursesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Menampilkan halaman sesuai indeks aktif
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Mengubah indeks saat tab ditekan
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Courses'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// Halaman 1: Home
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String studentName = 'Tandika Winata';
  static const String studentId = '2415051080';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Tab')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$studentId - $studentName',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Divider(height: 24),
            Text(
              'Selamat datang di Beranda Aplikasi Praktikum Flutter!',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman 2: Courses
class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  static const String studentName = 'Tandika Winata';
  static const String studentId = '2415051080';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Courses Tab')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$studentId - $studentName',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Divider(height: 24),
            Text(
              'Daftar mata kuliah responsif tersedia di sini.',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman 3: Profile
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String studentName = 'Tandika Winata';
  static const String studentId = '2415051080';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Tab')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$studentId - $studentName',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Divider(height: 24),
            Text('Nama: Tandika Winata', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('NIM: 2415051080', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
