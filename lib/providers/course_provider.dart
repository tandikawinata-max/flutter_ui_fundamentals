import 'package:flutter/foundation.dart';

import '../models/course.dart';
import '../repositories/course_repository.dart';

class CourseProvider extends ChangeNotifier {
  CourseProvider(this.repository);

  final CourseRepository repository;

  List<Course> _courses = [];
  final Set<String> _favorites = {};

  bool _isLoading = false;
  bool _isSaving = false;
  bool _hasLoaded = false;
  String? _error;

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

  List<Course> get favoriteCourses =>
      _courses.where((course) => _favorites.contains(course.code)).toList();

  int get favoriteCount => favoriteCourses.length;

  bool isFavorite(String code) => _favorites.contains(code);

  void toggleFavorite(String code) {
    if (_favorites.contains(code)) {
      _favorites.remove(code);
    } else {
      _favorites.add(code);
    }
    notifyListeners();
  }

  // GET DAN REFRESH
  Future<void> loadCourses() async {
    if (_isLoading) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _courses = await repository.getCourses();
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

  // POST - TAHAP 6
  Future<Course> createCourse(Course course) async {
    if (_isSaving) {
      throw StateError('Proses simpan sedang berlangsung');
    }

    _isSaving = true;
    notifyListeners();

    try {
      final created = await repository.createCourse(course);

      await loadCourses();

      if (_error != null) {
        throw Exception('Course tersimpan, tetapi refresh gagal: $_error');
      }

      return created;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  // PUT - TAHAP 7
  Future<void> updateCourse(int id, Course course) async {
    if (_isSaving) {
      throw StateError('Proses simpan sedang berlangsung');
    }

    _isSaving = true;
    notifyListeners();

    try {
      await repository.updateCourse(id, course);

      // Refresh dari backend, bukan menambah item lokal.
      await loadCourses();

      if (_error != null) {
        throw Exception('Course diperbarui, tetapi refresh gagal: $_error');
      }

      debugPrint('PUT berhasil: ${course.code}');
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }
}
