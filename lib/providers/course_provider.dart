import 'package:flutter/foundation.dart';

import '../models/course.dart';
import '../repositories/course_repository.dart';

class CourseProvider extends ChangeNotifier {
  CourseProvider(this.repository);

  final CourseRepository repository;

  // Data course dari REST API
  List<Course> _courses = [];

  // State untuk proses asynchronous
  bool _isLoading = false;
  String? _error;

  // Menyimpan kode course favorit
  final Set<String> _favorites = {};

  // ====================================
  // GETTER DATA COURSE
  // ====================================

  List<Course> get courses => List.unmodifiable(_courses);

  int get totalCourses => _courses.length;

  // ====================================
  // GETTER STATE
  // ====================================

  bool get isLoading => _isLoading;

  String? get error => _error;

  // ====================================
  // GETTER FAVORITES
  // ====================================

  Set<String> get favorites => Set.unmodifiable(_favorites);

  List<Course> get favoriteCourses {
    return _courses
        .where((course) => _favorites.contains(course.code))
        .toList();
  }

  int get favoriteCount => favoriteCourses.length;

  // ====================================
  // FUNGSI FAVORITES
  // ====================================

  bool isFavorite(String code) {
    return _favorites.contains(code);
  }

  void toggleFavorite(String code) {
    if (_favorites.contains(code)) {
      _favorites.remove(code);
    } else {
      _favorites.add(code);
    }

    notifyListeners();
  }

  // ====================================
  // MEMUAT DATA DARI REST API
  // ====================================

  Future<void> loadCourses() async {
    // Mencegah request ganda
    if (_isLoading) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Mengambil data melalui repository
      final List<Course> result = await repository.getCourses();

      // Memperbarui daftar course
      _courses = result;
    } catch (e) {
      // Menyimpan pesan kesalahan
      _error = e.toString();

      debugPrint('Gagal memuat course: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
