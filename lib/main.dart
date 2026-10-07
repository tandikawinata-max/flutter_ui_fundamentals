import 'package:flutter/material.dart';

void main() {
  runApp(const CourseExplorerApp());
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Explorer v2 - Tahap 2',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _currentIndex = 0;
  int _favoriteCount = 0;
  bool _isFavorite1 = false;
  bool _isFavorite2 = false;

  void _toggleFavorite1() {
    setState(() {
      _isFavorite1 = !_isFavorite1;
      _favoriteCount = _isFavorite1 ? _favoriteCount + 1 : _favoriteCount - 1;
    });
  }

  void _toggleFavorite2() {
    setState(() {
      _isFavorite2 = !_isFavorite2;
      _favoriteCount = _isFavorite2 ? _favoriteCount + 1 : _favoriteCount - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(
        favoriteCount: _favoriteCount,
        isFavorite1: _isFavorite1,
        onFavorite1Changed: _toggleFavorite1,
      ),
      CoursesScreen(
        isFavorite2: _isFavorite2,
        onFavorite2Changed: _toggleFavorite2,
      ),
      FavoritesScreen(
        favoriteCount: _favoriteCount, // Mengirim angka ke Favorites screen
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Prop Drilling & Angka Dinamis')),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Courses'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}

// ==========================================
// HOME SCREEN
// ==========================================
class HomeScreen extends StatefulWidget {
  final int favoriteCount;
  final bool isFavorite1;
  final VoidCallback onFavorite1Changed;

  const HomeScreen({
    super.key,
    required this.favoriteCount,
    required this.isFavorite1,
    required this.onFavorite1Changed,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const String studentName = 'Tandika Winata';
  static const String studentId = '2415051080';
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Identitas Mahasiswa
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: const Text(
              '$studentId • $studentName',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const SizedBox(height: 16),

          // Kotak Ringkasan Angka (Sesuai Mockup Worksheet)
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          'Courses',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '2',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          'Favorites',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        // Menampilkan Angka Dinamis dari Parent via Constructor
                        Text(
                          '${widget.favoriteCount}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Card Course 1
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'State Management',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(
                          widget.isFavorite1
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: widget.onFavorite1Changed,
                      ),
                    ],
                  ),
                  const Text(
                    'Status: active',
                    style: TextStyle(color: Colors.green),
                  ),
                  if (_isExpanded) ...[
                    const Divider(),
                    const Text(
                      'Mempelajari state management dan arsitektur mobile.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      child: Text(_isExpanded ? 'Sembunyikan' : 'Lihat Detail'),
                    ),
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

class CoursesScreen extends StatelessWidget {
  final bool isFavorite2;
  final VoidCallback onFavorite2Changed;

  const CoursesScreen({
    super.key,
    required this.isFavorite2,
    required this.onFavorite2Changed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const Text(
            'Daftar Mata Kuliah Lainnya',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              title: const Text('Dart Fundamentals'),
              subtitle: const Text('Status: done'),
              trailing: IconButton(
                icon: Icon(
                  isFavorite2 ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: onFavorite2Changed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  final int favoriteCount;

  const FavoritesScreen({super.key, required this.favoriteCount});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Jumlah Course Favorit saat ini: $favoriteCount',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
