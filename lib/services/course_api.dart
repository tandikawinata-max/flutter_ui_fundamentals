import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/course.dart';

const String apiUrl = 'https://course-api-pearl.vercel.app/courses';

Future<List<Course>> fetchCoursesTest() async {
  try {
    debugPrint('=== PERTEMUAN 7 TAHAP 3 ===');
    debugPrint('Nama: Tandika Winata');
    debugPrint('NIM: 2415051080');

    final response = await http.get(Uri.parse(apiUrl));

    debugPrint('Status code: ${response.statusCode}');

    if (response.statusCode != 200) {
      throw Exception('HTTP ${response.statusCode}');
    }

    final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;

    final List<Course> courses = jsonList
        .map((json) => Course.fromJson(json as Map<String, dynamic>))
        .toList();

    debugPrint('Jumlah course: ${courses.length}');

    for (final course in courses.take(3)) {
      debugPrint(
        '${course.code} | ${course.title} | '
        '${course.status}',
      );
    }

    if (courses.isNotEmpty) {
      debugPrint('Contoh toJson: ${courses.first.toJson()}');
    }

    return courses;
  } catch (error) {
    debugPrint('Gagal mengambil data: $error');
    rethrow;
  }
}
