# Course Explorer v2

Nama: Tandika Winata  
NIM: 2415051080  
Kelas: PTI 5B

## Struktur Arsitektur

Course Explorer v2 menggunakan pemisahan tanggung jawab dengan alur:

Screen / Widget → Provider → Repository → Service / Data Source

## Tanggung Jawab Folder

### models

Berisi model data aplikasi.  
Contoh: `Course` digunakan untuk merepresentasikan data course dari JSON.

### services

Berisi proses teknis untuk mengambil data dari sumber data.  
`CourseService` membaca file JSON menggunakan `rootBundle` dan `jsonDecode`.

### repositories

Berfungsi sebagai lapisan abstraksi antara Provider dan Service.  
`CourseRepository` menyediakan method untuk mengambil data course tanpa membuat Provider mengetahui detail sumber data.

### providers

Berisi state dan business logic aplikasi.  
`CourseProvider` mengelola data course, loading, error, dan shared favorite state menggunakan `ChangeNotifier`.

### screens

Berisi halaman utama aplikasi seperti Home, Courses, Course Detail, Favorites, dan Profile.

### widgets

Berisi komponen UI yang dapat digunakan kembali.  
Contohnya `CourseCard` untuk menampilkan informasi course.

## Dependency Direction

Screen / Widget  
↓  
Provider  
↓  
Repository  
↓  
Service  
↓  
JSON

UI tidak membaca JSON secara langsung dan Provider tidak menyimpan `BuildContext`.
