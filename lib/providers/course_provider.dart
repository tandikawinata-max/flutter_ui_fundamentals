import 'package:flutter/foundation.dart';

import '../models/course.dart';
import '../repositories/course_repository.dart';

class CourseProvider extends ChangeNotifier {
  CourseProvider(this.repository);

  final CourseRepository repository;

  List<Course> _courses = [];
  bool _isLoading = false;
  String? _error;
  bool _hasLoaded = false;

  final Set<String> _favorites = {};

  // DATA COURSE
  List<Course> get courses => List.unmodifiable(_courses);

  int get totalCourses => _courses.length;

  // ASYNCHRONOUS STATE
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasLoaded => _hasLoaded;

  bool get isEmpty =>
      _hasLoaded && !_isLoading && _error == null && _courses.isEmpty;

  bool get isSuccess =>
      _hasLoaded && !_isLoading && _error == null && _courses.isNotEmpty;

  // FAVORITES
  Set<String> get favorites => Set.unmodifiable(_favorites);

  List<Course> get favoriteCourses =>
      _courses.where((course) => _favorites.contains(course.code)).toList();

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

  // LOAD DATA
  Future<void> loadCourses() async {
    if (_isLoading) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await repository.getCourses();

      _courses = result;
      _error = null;

      debugPrint('HTTP GET berhasil: ${_courses.length} course');
    } catch (e) {
      _error = e.toString();

      debugPrint('HTTP GET gagal: $e');
    } finally {
      _hasLoaded = true;
      _isLoading = false;
      notifyListeners();
    }
  }
}
