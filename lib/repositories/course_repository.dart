import '../models/course.dart';
import '../services/course_api.dart';

class CourseRepository {
  CourseRepository(this.service);

  final CourseApiService service;

  // Mengambil seluruh data
  Future<List<Course>> getCourses() {
    return service.getCourses();
  }

  // Menambahkan course baru
  Future<Course> createCourse(Course course) {
    return service.createCourse(course);
  }
}
