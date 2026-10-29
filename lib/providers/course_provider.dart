import 'package:flutter/foundation.dart';

import '../models/course.dart';
import '../repositories/course_repository.dart';

class CourseProvider extends ChangeNotifier {
  CourseProvider(this.repository);

  final CourseRepository repository;

  List<Course> _courses = [];

  bool _isLoading = false;
  bool _isSaving = false;
  bool _hasLoaded = false;

  String? _error;

  final Set<String> _favorites = {};

  // DATA COURSE
  List<Course> get courses => List.unmodifiable(_courses);

  int get totalCourses => _courses.length;

  // ASYNC STATE
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  bool get hasLoaded => _hasLoaded;

  String? get error => _error;

  bool get isEmpty =>
      _hasLoaded && !_isLoading && _error == null && _courses.isEmpty;

  bool get isSuccess =>
      _hasLoaded && !_isLoading && _error == null && _courses.isNotEmpty;

  // FAVORITES
  Set<String> get favorites => Set.unmodifiable(_favorites);

  List<Course> get favoriteCourses {
    return _courses
        .where((course) => _favorites.contains(course.code))
        .toList();
  }

  int get favoriteCount => favoriteCourses.length;

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

  // TAHAP 5: MEMUAT DATA
  Future<void> loadCourses() async {
    if (_isLoading) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await repository.getCourses();

      _courses = result;
      _error = null;

      debugPrint('GET berhasil: ${_courses.length} course');
    } catch (e) {
      _error = e.toString();
      debugPrint('GET gagal: $e');
    } finally {
      _hasLoaded = true;
      _isLoading = false;
      notifyListeners();
    }
  }

  // TAHAP 6: MENAMBAH COURSE
  Future<Course> createCourse(Course course) async {
    if (_isSaving) {
      throw StateError('Proses penyimpanan masih berlangsung');
    }

    _isSaving = true;
    notifyListeners();

    try {
      final created = await repository.createCourse(course);

      // Mengambil ulang data dari server.
      await loadCourses();

      if (_error != null) {
        throw Exception(
          'Course tersimpan, tetapi refresh gagal: '
          '$_error',
        );
      }

      debugPrint('POST berhasil: ${created.code}');

      return created;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }
}
