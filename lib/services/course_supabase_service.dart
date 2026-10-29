import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/course.dart';
import 'course_data_source.dart';

// Pertemuan 7 - Tahap 13
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

    return data.map((item) => Course.fromJson(item)).toList();
  }

  // TAHAP 13 - INSERT
  @override
  Future<Course> createCourse(Course course) async {
    final row = await supabase
        .from('courses')
        .insert(course.toJson())
        .select()
        .single();

    return Course.fromJson(row);
  }

  // TAHAP 14 - UPDATE (belum dibuat)
  @override
  Future<void> updateCourse(int id, Course course) async {
    throw UnimplementedError('UPDATE akan dibuat pada Tahap 14');
  }

  // TAHAP 15 - DELETE (belum dibuat)
  @override
  Future<void> deleteCourse(int id) async {
    throw UnimplementedError('DELETE akan dibuat pada Tahap 15');
  }
}
