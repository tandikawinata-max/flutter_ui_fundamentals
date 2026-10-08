import 'package:flutter/material.dart';

const String studentName = 'Tandika Winata';
const String studentId = '2415051080';

void main() {
  runApp(const MyApp());
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

  // State dari Tahap 3
  bool _isFavorite = false;

  // ValueNotifier untuk Tahap 4
  final ValueNotifier<int> _favoriteCount = ValueNotifier<int>(0);

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  void _increaseFavoriteCount() {
    // Tidak perlu setState()
    _favoriteCount.value++;
  }

  void _resetFavoriteCount() {
    // Tidak perlu setState()
    _favoriteCount.value = 0;
  }

  @override
  void dispose() {
    _favoriteCount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(
        favoriteCount: _favoriteCount,
        onIncreaseFavorite: _increaseFavoriteCount,
        onResetFavorite: _resetFavoriteCount,
      ),
      CoursesScreen(
        isFavorite: _isFavorite,
        onFavoriteChanged: _toggleFavorite,
      ),
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
// HOME SCREEN - TAHAP 4
// ==================================================

class HomeScreen extends StatelessWidget {
  final ValueNotifier<int> favoriteCount;
  final VoidCallback onIncreaseFavorite;
  final VoidCallback onResetFavorite;

  const HomeScreen({
    super.key,
    required this.favoriteCount,
    required this.onIncreaseFavorite,
    required this.onResetFavorite,
  });

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
            'Tahap 4',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 4),

          const Text(
            'ValueNotifier dan ValueListenableBuilder',
            style: TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 24),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Eksperimen Jumlah Favorite',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),

                  // Mendengarkan perubahan ValueNotifier
                  ValueListenableBuilder<int>(
                    valueListenable: favoriteCount,
                    builder: (context, value, child) {
                      return Text(
                        'Jumlah Favorite: $value',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton.icon(
                    onPressed: onIncreaseFavorite,
                    icon: const Icon(Icons.favorite),
                    label: const Text('Tambah Favorite'),
                  ),

                  const SizedBox(height: 8),

                  OutlinedButton.icon(
                    onPressed: onResetFavorite,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset'),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Nilai favorite diperbarui menggunakan ValueNotifier tanpa memanggil setState().',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================================================
// COURSES SCREEN
// Tetap mempertahankan contoh Tahap 3
// ==================================================

class CoursesScreen extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onFavoriteChanged;

  const CoursesScreen({
    super.key,
    required this.isFavorite,
    required this.onFavoriteChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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

          Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.flutter_dash)),
              title: const Text('Flutter State Management'),
              subtitle: Text(
                isFavorite ? 'Status: Favorite' : 'Status: Belum Favorite',
              ),
              trailing: IconButton(
                onPressed: onFavoriteChanged,
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
              ),
            ),
          ),
        ],
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
