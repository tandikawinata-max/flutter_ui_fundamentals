import '../models/course.dart';
import '../services/course_data_source.dart';

class CourseRepository {
  CourseRepository(this.dataSource);

  final CourseDataSource dataSource;

  // READ
  Future<List<Course>> getCourses() {
    return dataSource.getCourses();
  }

  // CREATE
  Future<Course> createCourse(Course course) {
    return dataSource.createCourse(course);
  }

  // UPDATE
  Future<void> updateCourse(int id, Course course) {
    return dataSource.updateCourse(id, course);
  }

  // DELETE
  Future<void> deleteCourse(int id) {
    return dataSource.deleteCourse(id);
  }
}
