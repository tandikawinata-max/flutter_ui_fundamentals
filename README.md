# Course Data Manager

## Identitas Mahasiswa

- Nama: Tandika Winata
- NIM: 2415051080
- Mata Kuliah: Pemrograman Mobile
- Pertemuan: 7

## Deskripsi

Course Data Manager merupakan pengembangan
aplikasi Course Explorer v2 berbasis Flutter
untuk mengelola data mata kuliah menggunakan
backend Supabase.

Aplikasi mempertahankan navigasi responsif,
halaman detail course, dan fitur Favorites
dari praktikum sebelumnya.

## Fitur

- Menampilkan daftar course (SELECT)
- Menambahkan course (INSERT)
- Mengubah course (UPDATE)
- Menghapus course (DELETE)
- Konfirmasi sebelum menghapus data
- Validasi form course
- Loading, empty, success, dan error state
- Tombol Retry saat pengambilan data gagal
- Feedback menggunakan SnackBar
- Favorites berdasarkan kode course
- Navigasi responsif

## Teknologi

- Flutter dan Dart
- Provider untuk state management
- Supabase Flutter SDK
- PostgreSQL melalui Supabase
- Git dan GitHub

## Struktur Arsitektur

- Model: representasi data Course
- Data Source/Service: komunikasi backend
- Repository: abstraksi akses data
- Provider: pengelolaan state aplikasi
- Screen: antarmuka pengguna

## Backend

Database utama aplikasi menggunakan
Supabase PostgreSQL.

Tabel: public.courses

Kolom:

- id
- code
- title
- credits
- status
- created_at

Service utama:
lib/services/course_supabase_service.dart

Service REST API dari tahap sebelumnya
tetap disimpan untuk dokumentasi praktikum.

## Cara Menjalankan

1. Pastikan Flutter SDK sudah terinstal.
2. Buka folder project pada VS Code.
3. Jalankan:

   flutter pub get

4. Siapkan Supabase Project URL dan
   publishable key milik project.

5. Jalankan aplikasi:

   flutter run -d chrome \
    --dart-define=SUPABASE_URL=URL_PROJECT \
    --dart-define=SUPABASE_PUBLISHABLE_KEY=KEY_PUBLISHABLE

Perintah di atas ditulis untuk shell yang
mendukung pemisahan baris dengan backslash.
Jika memakai PowerShell, tulis perintah
dalam satu baris.

Gunakan publishable key pada client.
Jangan pernah memasukkan service_role
atau secret server ke dalam aplikasi.

## Keamanan

- Row Level Security (RLS) diaktifkan.
- Akses database mengikuti policy Supabase.
- Secret key server tidak disimpan di Flutter.
- Policy anonim untuk laboratorium tidak
  dimaksudkan sebagai konfigurasi produksi.

## Repository

https://github.com/tandikawinata-max/flutter_ui_fundamentals
