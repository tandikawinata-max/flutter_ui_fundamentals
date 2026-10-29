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
  }

  Future<void> _openEditCourse(BuildContext context, Course course) async {
    await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => CourseFormScreen(course: course)),
    );
  }

  Future<void> _confirmDelete(BuildContext context, Course course) async {
    final provider = context.read<CourseProvider>();

    if (provider.isBusy) return;

    if (course.id == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('ID course tidak tersedia')));
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Hapus Course?'),
          content: Text(
            'Apakah kamu yakin ingin menghapus '
            '"${course.title}" (${course.code})?\n\n'
            'Data yang sudah dihapus tidak dapat '
            'dikembalikan melalui fitur ini.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    // Periksa context setelah dialog.
    if (!context.mounted) return;

    if (confirmed != true) return;

    try {
      await provider.deleteCourse(course);

      // Periksa context setelah await DELETE.
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${course.title} berhasil dihapus')),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$e'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                    onPressed: provider.isBusy
                        ? null
                        : () => context.read<CourseProvider>().loadCourses(),
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: provider.isBusy
                      ? null
                      : () => _openAddCourse(context),
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text('Tambah Course'),
                ),
              ),
              if (provider.isDeleting) ...[
                const SizedBox(height: 12),
                const LinearProgressIndicator(),
                const SizedBox(height: 4),
                const Text('Menghapus course...'),
              ],
            ],
          ),
        ),
        Expanded(child: _buildContent(context, provider)),
      ],
    );
  }

  Widget _buildContent(BuildContext context, CourseProvider provider) {
    // LOADING
    if (provider.isLoading || !provider.hasLoaded) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
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
      return const Center(child: Text('Data course belum tersedia'));
    }

    // SUCCESS
    return RefreshIndicator(
      onRefresh: () => context.read<CourseProvider>().loadCourses(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          final columns = width < 600
              ? 1
              : width < 840
              ? 2
              : 3;

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

          return GridView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              mainAxisExtent: 230,
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
        onTap: () => _showCourseDetail(context, course),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(child: Icon(Icons.menu_book_rounded)),
              const SizedBox(width: 10),
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
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
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
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    tooltip: 'Edit Course',
                    onPressed: provider.isBusy
                        ? null
                        : () => _openEditCourse(context, course),
                    icon: const Icon(Icons.edit_outlined),
                  ),
                  IconButton(
                    tooltip: 'Hapus Course',
                    onPressed: provider.isBusy
                        ? null
                        : () => _confirmDelete(context, course),
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                  ),
                  IconButton(
                    tooltip: 'Favorite',
                    onPressed: provider.isDeleting
                        ? null
                        : () => context.read<CourseProvider>().toggleFavorite(
                            course.code,
                          ),
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.deepPurple : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // DIALOG DETAIL
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
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Tutup'),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.pop(dialogContext);
                _openEditCourse(context, course);
              },
              icon: const Icon(Icons.edit),
              label: const Text('Edit'),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.pop(dialogContext);
                _confirmDelete(context, course);
              },
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              label: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
}
