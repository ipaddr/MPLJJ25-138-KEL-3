import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 5),
              Center(
                child: Column(
                  children: [
                    Image.asset('assets/logo/logonutrikita.png', height: 150),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Nama Field
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nama',
                  style:
                      theme
                          .textTheme
                          .labelLarge, // Menggunakan gaya teks labelLarge dari TextTheme
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Masukkan nama Anda', // Perbaikan ejaan
                ),
              ),
              const SizedBox(height: 18), // Spasi antar field
              // NISN Field
              Align(
                alignment: Alignment.centerLeft,
                child: Text('NISN', style: theme.textTheme.labelLarge),
              ),
              const SizedBox(height: 10),
              TextFormField(
                keyboardType:
                    TextInputType.number, // Sesuaikan dengan input NISN
                decoration: const InputDecoration(
                  hintText: 'Masukkan NISN Anda', // Perbaikan ejaan
                ),
              ),
              const SizedBox(height: 18),

              // Email Field
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Email', style: theme.textTheme.labelLarge),
              ),
              const SizedBox(height: 10),
              TextFormField(
                keyboardType:
                    TextInputType.emailAddress, // Sesuaikan dengan input email
                decoration: const InputDecoration(
                  hintText: 'Masukkan email Anda', // Perbaikan ejaan
                ),
              ),
              const SizedBox(height: 18),

              // Password Field
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Password', style: theme.textTheme.labelLarge),
              ),
              const SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Masukkan password Anda', // Perbaikan ejaan
                ),
              ),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Minimal 8 karakter',
                  style:
                      theme
                          .textTheme
                          .bodySmall, // Menggunakan gaya teks bodySmall dari TextTheme
                ),
              ),
              const SizedBox(height: 32), // Spasi sebelum tombol
              // Tombol Daftar Sekarang
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implementasi logika pendaftaran
                    Navigator.pop(
                      context,
                    ); // Contoh: Kembali ke halaman login setelah daftar
                  },
                  // Style akan otomatis diambil dari ElevatedButtonThemeData di ThemeData
                  // yang sudah kita set dengan AppColors.secondaryOrange
                  child: const Text(
                    'DAFTAR SEKARANG',
                  ), // Warna dan style teks diambil dari tema
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
