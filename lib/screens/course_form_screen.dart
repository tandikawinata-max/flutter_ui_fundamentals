import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course_provider.dart';

class CourseFormScreen extends StatefulWidget {
  const CourseFormScreen({super.key, this.course});

  final Course? course;

  @override
  State<CourseFormScreen> createState() => _CourseFormScreenState();
}

class _CourseFormScreenState extends State<CourseFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _codeController;
  late final TextEditingController _titleController;
  late final TextEditingController _creditsController;

  late String _status;
  bool _isSubmitting = false;

  bool get isEditing => widget.course != null;

  @override
  void initState() {
    super.initState();

    final course = widget.course;

    _codeController = TextEditingController(text: course?.code ?? '');
    _titleController = TextEditingController(text: course?.title ?? '');
    _creditsController = TextEditingController(
      text: course?.credits.toString() ?? '',
    );
    _status = course?.status ?? 'planned';
  }

  @override
  void dispose() {
    _codeController.dispose();
    _titleController.dispose();
    _creditsController.dispose();
    super.dispose();
  }

  Future<void> _saveCourse() async {
    if (_isSubmitting || context.read<CourseProvider>().isSaving) {
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final course = Course(
      id: widget.course?.id,
      code: _codeController.text.trim(),
      title: _titleController.text.trim(),
      credits: int.parse(_creditsController.text.trim()),
      status: _status,
    );

    setState(() {
      _isSubmitting = true;
    });

    try {
      final provider = context.read<CourseProvider>();

      if (isEditing) {
        final id = widget.course!.id;

        if (id == null) {
          throw StateError('ID course tidak tersedia untuk update');
        }

        await provider.updateCourse(id, course);
      } else {
        await provider.createCourse(course);
      }

      if (!mounted) return;

      // SnackBar ditampilkan setelah operasi selesai.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isEditing
                ? 'Course berhasil diperbarui'
                : 'Course berhasil ditambahkan',
          ),
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menyimpan course: $e'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSaving = context.select<CourseProvider, bool>(
      (provider) => provider.isSaving,
    );

    final busy = _isSubmitting || isSaving;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Course' : 'Tambah Course')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                isEditing ? 'Edit Mata Kuliah' : 'Tambah Mata Kuliah',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text('Tandika Winata - 2415051080'),
              const SizedBox(height: 24),

              // KODE COURSE
              TextFormField(
                controller: _codeController,
                readOnly: isEditing,
                enabled: !busy,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  labelText: 'Kode Course',
                  helperText: isEditing
                      ? 'Kode tidak dapat diubah saat edit'
                      : null,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Kode course wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // JUDUL
              TextFormField(
                controller: _titleController,
                enabled: !busy,
                decoration: const InputDecoration(
                  labelText: 'Nama Course',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama course wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // SKS
              TextFormField(
                controller: _creditsController,
                enabled: !busy,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Jumlah SKS',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final credits = int.tryParse(value?.trim() ?? '');

                  if (credits == null) {
                    return 'SKS harus berupa angka bulat';
                  }
                  if (credits <= 0) {
                    return 'SKS harus lebih dari 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // STATUS
              DropdownButtonFormField<String>(
                initialValue: _status,
                decoration: const InputDecoration(
                  labelText: 'Status Course',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'planned', child: Text('Planned')),
                  DropdownMenuItem(value: 'active', child: Text('Active')),
                  DropdownMenuItem(value: 'done', child: Text('Done')),
                ],
                onChanged: busy
                    ? null
                    : (value) {
                        if (value != null) {
                          setState(() {
                            _status = value;
                          });
                        }
                      },
              ),
              const SizedBox(height: 28),

              // SIMPAN
              FilledButton.icon(
                onPressed: busy ? null : _saveCourse,
                icon: busy
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save),
                label: Text(
                  busy
                      ? 'Menyimpan...'
                      : isEditing
                      ? 'Simpan Perubahan'
                      : 'Simpan Course',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
