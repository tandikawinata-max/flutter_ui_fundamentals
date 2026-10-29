import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/course.dart';
import 'course_data_source.dart';

// Pertemuan 7 - Tahap 12
// Tandika Winata - 2415051080

class CourseSupabaseService implements CourseDataSource {
  final SupabaseClient supabase = Supabase.instance.client;

  // TAHAP 12 - SELECT
  @override
  Future<List<Course>> getCourses() async {
    final data = await supabase
        .from('courses')
        .select()
        .order('id', ascending: true);

    return data.map((item) {
      return Course.fromJson(item);
    }).toList();
  }

  // TAHAP 13 - INSERT
  @override
  Future<Course> createCourse(Course course) async {
    throw UnimplementedError('INSERT akan dibuat pada Tahap 13');
  }

  // TAHAP 14 - UPDATE
  @override
  Future<void> updateCourse(int id, Course course) async {
    throw UnimplementedError('UPDATE akan dibuat pada Tahap 14');
  }

  // TAHAP 15 - DELETE
  @override
  Future<void> deleteCourse(int id) async {
    throw UnimplementedError('DELETE akan dibuat pada Tahap 15');
  }
}
