import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tahap 13: Form Validation',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const FormValidationPage(),
    );
  }
}

class FormValidationPage extends StatefulWidget {
  const FormValidationPage({super.key});

  @override
  State<FormValidationPage> createState() => _FormValidationPageState();
}

class _FormValidationPageState extends State<FormValidationPage> {
  // GlobalKey untuk mengontrol dan memvalidasi Form
  final _formKey = GlobalKey<FormState>();

  // Controller untuk mengambil nilai input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  static const String studentName = 'Tandika Winata';
  static const String studentId = '2415051080';

  @override
  void dispose() {
    _nameController.dispose();
    _nimController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // Memeriksa apakah seluruh validasi TextFormField terpenuhi
    if (_formKey.currentState!.validate()) {
      // Jika valid, tampilkan pesan sukses
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Form berhasil disubmit oleh ${_nameController.text}!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 13: Form & Validasi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                '$studentId - $studentName',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Divider(height: 24),
              const Text(
                'Form Masukan / Komentar Mahasiswa',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Input Nama
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama lengkap tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Input NIM
              TextFormField(
                controller: _nimController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'NIM',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NIM tidak boleh kosong';
                  }
                  if (value.length < 10) {
                    return 'NIM minimal 10 digit';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Input Komentar
              TextFormField(
                controller: _commentController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Komentar / Pesan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Komentar tidak boleh kosong';
                  }
                  if (value.length < 5) {
                    return 'Komentar terlalu pendek (minimal 5 karakter)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Tombol Submit
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Validasi & Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
