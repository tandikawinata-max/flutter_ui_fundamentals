import '../models/course.dart';
import '../services/course_api.dart';

class CourseRepository {
  CourseRepository(this.service);

  final CourseApiService service;

  Future<List<Course>> getCourses() {
    return service.getCourses();
  }

  Future<Course> createCourse(Course course) {
    return service.createCourse(course);
  }

  // TAHAP 7
  Future<void> updateCourse(int id, Course course) {
    return service.updateCourse(id, course);
  }
}
