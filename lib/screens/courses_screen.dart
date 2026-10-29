import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course_provider.dart';
import '../widgets/error_view.dart';
import 'course_form_screen.dart';

const String studentName = 'Tandika Winata';
const String studentId = '2415051080';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  Future<void> _openAddCourse(BuildContext context) async {
    await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const CourseFormScreen()),
    );

    if (!context.mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ======================================
        // HEADER
        // ======================================
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Courses',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 6),

              const Text('$studentId - $studentName'),

              const SizedBox(height: 8),

              Row(
                children: [
                  Expanded(
                    child: Text('${provider.totalCourses} courses available'),
                  ),

                  IconButton(
                    tooltip: 'Refresh Data',
                    onPressed: provider.isLoading
                        ? null
                        : () {
                            context.read<CourseProvider>().loadCourses();
                          },
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // ==================================
              // TOMBOL TAMBAH COURSE - TAHAP 6
              // ==================================
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: provider.isSaving
                      ? null
                      : () => _openAddCourse(context),
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text('Tambah Course'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),

        // ======================================
        // CONTENT
        // ======================================
        Expanded(child: _buildContent(context, provider)),
      ],
    );
  }

  // ==========================================
  // TAHAP 5: LOADING, ERROR, EMPTY, SUCCESS
  // ==========================================

  Widget _buildContent(BuildContext context, CourseProvider provider) {
    // LOADING
    if (provider.isLoading || !provider.hasLoaded) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Memuat data course...'),
          ],
        ),
      );
    }

    // ERROR
    if (provider.error != null) {
      return ErrorView(
        message: provider.error!,
        onRetry: () {
          context.read<CourseProvider>().loadCourses();
        },
      );
    }

    // EMPTY
    if (provider.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_outlined, size: 58, color: Colors.grey),
            SizedBox(height: 12),
            Text('Data course belum tersedia'),
          ],
        ),
      );
    }

    // SUCCESS
    return RefreshIndicator(
      onRefresh: () => context.read<CourseProvider>().loadCourses(),

      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          // Layout responsive dari Pertemuan 5
          final int columns = width < 600
              ? 1
              : width < 840
              ? 2
              : 3;

          // COMPACT: LIST VIEW
          if (columns == 1) {
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: provider.courses.length,
              itemBuilder: (context, index) {
                return _buildCourseCard(
                  context,
                  provider.courses[index],
                  provider,
                );
              },
            );
          }

          // MEDIUM / EXPANDED: GRID VIEW
          return GridView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              mainAxisExtent: 190,
            ),
            itemCount: provider.courses.length,
            itemBuilder: (context, index) {
              return _buildCourseCard(
                context,
                provider.courses[index],
                provider,
              );
            },
          );
        },
      ),
    );
  }

  // ==========================================
  // CARD COURSE
  // ==========================================

  Widget _buildCourseCard(
    BuildContext context,
    Course course,
    CourseProvider provider,
  ) {
    final isFavorite = provider.isFavorite(course.code);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          _showCourseDetail(context, course);
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(child: Icon(Icons.menu_book_rounded)),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(course.code),

                    const SizedBox(height: 12),

                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        Chip(
                          label: Text('${course.credits} SKS'),
                          visualDensity: VisualDensity.compact,
                        ),
                        Chip(
                          label: Text(course.status),
                          visualDensity: VisualDensity.compact,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // FAVORITE
              IconButton(
                tooltip: isFavorite ? 'Hapus Favorite' : 'Tambah Favorite',
                onPressed: () {
                  context.read<CourseProvider>().toggleFavorite(course.code);
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.deepPurple : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // DETAIL COURSE
  // ==========================================

  void _showCourseDetail(BuildContext context, Course course) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(course.title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ID: ${course.id ?? "-"}'),
              Text('Kode: ${course.code}'),
              Text('SKS: ${course.credits}'),
              Text('Status: ${course.status}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }
}
