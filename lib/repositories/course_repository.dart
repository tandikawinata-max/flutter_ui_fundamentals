import '../models/course.dart';
import '../services/course_api.dart';

class CourseRepository {
  CourseRepository(this.service);

  final CourseApiService service;

  Future<List<Course>> getCourses() async {
    return await service.getCourses();
  }
}
