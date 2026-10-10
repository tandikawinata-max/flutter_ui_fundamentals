import 'package:flutter/foundation.dart';

import '../models/course.dart';
import '../repositories/course_repository.dart';

class CourseProvider extends ChangeNotifier {
  final CourseRepository repository;

  CourseProvider(this.repository);

  // =========================
  // COURSE DATA
  // =========================

  List<Course> courses = [];

  bool isLoading = false;

  String? error;

  // =========================
  // FAVORITE SHARED STATE
  // =========================

  final Set<String> _favorites = {};

  Set<String> get favorites {
    return Set.unmodifiable(_favorites);
  }

  int get favoriteCount {
    return _favorites.length;
  }

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

  // Hanya mengambil Course yang menjadi favorite
  List<Course> get favoriteCourses {
    return courses.where((course) => _favorites.contains(course.code)).toList();
  }

  // =========================
  // LOAD COURSE
  // =========================

  Future<void> loadCourses() async {
    isLoading = true;
    error = null;

    notifyListeners();

    try {
      courses = await repository.getCourses();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }
}
