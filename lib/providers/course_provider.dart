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
  bool _isDeleting = false;
  bool _hasLoaded = false;

  String? _error;

  // DATA COURSE
  List<Course> get courses => List.unmodifiable(_courses);

  int get totalCourses => _courses.length;

  // ASYNC STATE
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  bool get isDeleting => _isDeleting;
  bool get hasLoaded => _hasLoaded;
  String? get error => _error;

  bool get isBusy => _isLoading || _isSaving || _isDeleting;

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

  // TAHAP 5: HTTP GET DAN REFRESH
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

  // TAHAP 6: HTTP POST
  Future<Course> createCourse(Course course) async {
    if (_isSaving || _isDeleting) {
      throw StateError('Operasi data sedang berlangsung');
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

  // TAHAP 7: HTTP PUT
  Future<void> updateCourse(int id, Course course) async {
    if (_isSaving || _isDeleting) {
      throw StateError('Operasi data sedang berlangsung');
    }

    _isSaving = true;
    notifyListeners();

    try {
      await repository.updateCourse(id, course);

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

  // TAHAP 8: HTTP DELETE
  Future<void> deleteCourse(Course course) async {
    if (_isSaving || _isDeleting) {
      throw StateError('Operasi data sedang berlangsung');
    }

    final id = course.id;

    if (id == null) {
      throw StateError('ID course tidak tersedia');
    }

    _isDeleting = true;
    notifyListeners();

    try {
      // Hapus data dari REST API dosen.
      await repository.deleteCourse(id);

      // Setelah DELETE sukses, hapus favorite.
      _favorites.remove(course.code);

      // Hilangkan item dari daftar lokal.
      _courses = _courses.where((item) => item.id != id).toList();

      notifyListeners();

      // Ambil kembali data terbaru dari server.
      await loadCourses();

      if (_error != null) {
        throw Exception(
          'Course sudah dihapus, '
          'tetapi refresh gagal: $_error',
        );
      }

      debugPrint('DELETE berhasil: ${course.code}');
    } finally {
      _isDeleting = false;
      notifyListeners();
    }
  }
}
