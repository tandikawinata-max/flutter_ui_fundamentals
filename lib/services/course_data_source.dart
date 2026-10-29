import '../models/course.dart';

abstract class CourseDataSource {
  // READ
  Future<List<Course>> getCourses();

  // CREATE
  Future<Course> createCourse(Course course);

  // UPDATE
  Future<void> updateCourse(int id, Course course);

  // DELETE
  Future<void> deleteCourse(int id);
}
