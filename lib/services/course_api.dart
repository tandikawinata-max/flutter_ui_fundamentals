import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/course.dart';

class CourseApiService {
  CourseApiService(this.baseUrl);

  final String baseUrl;

  // TAHAP 4: HTTP GET
  Future<List<Course>> getCourses() async {
    final response = await http.get(Uri.parse('$baseUrl/courses'));

    if (response.statusCode != 200) {
      throw Exception('Gagal mengambil course: HTTP ${response.statusCode}');
    }

    final data = jsonDecode(response.body) as List<dynamic>;

    return data.map((item) {
      return Course.fromJson(item as Map<String, dynamic>);
    }).toList();
  }

  // TAHAP 6: HTTP POST
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
      'Gagal menambah course: HTTP '
      '${response.statusCode} ${response.body}',
    );
  }

  // TAHAP 7: HTTP PUT
  Future<void> updateCourse(int id, Course course) async {
    final response = await http.put(
      Uri.parse('$baseUrl/courses/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(course.toJson()),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Gagal memperbarui course: HTTP '
        '${response.statusCode} ${response.body}',
      );
    }
  }

  // TAHAP 8: HTTP DELETE
  Future<void> deleteCourse(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/courses/$id'));

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Gagal menghapus course: HTTP '
        '${response.statusCode} ${response.body}',
      );
    }
  }
}
