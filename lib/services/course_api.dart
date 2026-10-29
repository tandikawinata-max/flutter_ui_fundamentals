import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/course.dart';
import 'course_data_source.dart';

class CourseApiService implements CourseDataSource {
  CourseApiService(this.baseUrl);

  final String baseUrl;

  // ===================================
  // HTTP GET - TAHAP 4
  // ===================================
  @override
  Future<List<Course>> getCourses() async {
    final response = await http.get(Uri.parse('$baseUrl/courses'));

    if (response.statusCode != 200) {
      throw Exception(
        'Gagal mengambil course: '
        'HTTP ${response.statusCode} '
        '${response.body}',
      );
    }

    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

    return data.map((item) {
      return Course.fromJson(item as Map<String, dynamic>);
    }).toList();
  }

  // ===================================
  // HTTP POST - TAHAP 6
  // ===================================
  @override
  Future<Course> createCourse(Course course) async {
    final response = await http.post(
      Uri.parse('$baseUrl/courses'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(course.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Course.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }

    throw Exception(
      'Gagal menambah course: '
      'HTTP ${response.statusCode} '
      '${response.body}',
    );
  }

  // ===================================
  // HTTP PUT - TAHAP 7
  // ===================================
  @override
  Future<void> updateCourse(int id, Course course) async {
    final response = await http.put(
      Uri.parse('$baseUrl/courses/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(course.toJson()),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Gagal memperbarui course: '
        'HTTP ${response.statusCode} '
        '${response.body}',
      );
    }
  }

  // ===================================
  // HTTP DELETE - TAHAP 8
  // ===================================
  @override
  Future<void> deleteCourse(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/courses/$id'));

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Gagal menghapus course: '
        'HTTP ${response.statusCode} '
        '${response.body}',
      );
    }
  }
}
