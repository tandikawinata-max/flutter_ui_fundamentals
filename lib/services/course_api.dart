import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const String apiUrl = 'https://course-api-pearl.vercel.app/courses';

Future<void> fetchCoursesTest() async {
  try {
    debugPrint('=== PERTEMUAN 7 TAHAP 2 ===');
    debugPrint('Nama: Tandika Winata');
    debugPrint('NIM: 2415051080');

    debugPrint('Memulai request GET...');
    debugPrint('Endpoint: $apiUrl');

    final response = await http.get(Uri.parse(apiUrl));

    debugPrint('Status code: ${response.statusCode}');

    if (response.statusCode == 200) {
      final List<dynamic> courses = jsonDecode(response.body) as List<dynamic>;

      debugPrint('GET berhasil!');
      debugPrint('Jumlah course: ${courses.length}');

      for (final course in courses.take(3)) {
        debugPrint('${course['code']} - ${course['title']}');
      }
    } else {
      throw Exception('HTTP ${response.statusCode}');
    }
  } catch (error) {
    debugPrint('Terjadi error: $error');
  }
}
