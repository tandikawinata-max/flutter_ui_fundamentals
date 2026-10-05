import 'package:flutter/material.dart';

void main() {
  runApp(const DebugApp());
}

class DebugApp extends StatelessWidget {
  const DebugApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tahap 16: Debugging & Error Handling',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
      ),
      home: const DebugPage(),
    );
  }
}

class DebugPage extends StatefulWidget {
  const DebugPage({super.key});

  @override
  State<DebugPage> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  static const String studentName = 'Tandika Winata';
  static const String studentId = '2415051080';

  bool _isLoading = false;
  String? _errorMessage;
  String _dataResult = 'Belum ada data dimuat.';

  // Simulasi fungsi asinkron dengan potensi error
  Future<void> _fetchDataWithSimulation({bool triggerError = false}) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Simulasi jeda jaringan
      await Future.delayed(const Duration(seconds: 2));

      if (triggerError) {
        throw Exception('Gagal terhubung ke server (Network Eror)');
      }

      setState(() {
        _dataResult = 'Data berhasil dimuat dengan aman!';
        _isLoading = false;
      });
    } catch (e) {
      // Menangkap error dan menyimpannya ke state tanpa membuat aplikasi crash
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 16: Debugging & Error Handling')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '$studentId - $studentName',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 24),
            const Text(
              'Simulasi Penanganan Kesalahan (Error Handling):',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Area Tampilan Hasil / Error State
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _errorMessage != null
                  ? Column(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 40,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _errorMessage!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : Text(_dataResult, style: const TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 24),

            // Tombol Simulasi Berhasil
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: _isLoading
                  ? null
                  : () => _fetchDataWithSimulation(triggerError: false),
              icon: const Icon(Icons.check_circle),
              label: const Text('Simulasi Ambil Data Sukses'),
            ),
            const SizedBox(height: 12),

            // Tombol Simulasi Error
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: _isLoading
                  ? null
                  : () => _fetchDataWithSimulation(triggerError: true),
              icon: const Icon(Icons.warning),
              label: const Text('Simulasi Terjadi Error (Catch Exception)'),
            ),
          ],
        ),
      ),
    );
  }
}
