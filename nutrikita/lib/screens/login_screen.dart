import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'register_screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 5),
                // Logo NutriKita
                Center(
                  child: Column(
                    children: [
                      Image.asset('assets/logo/logonutrikita.png', height: 150),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),

                const SizedBox(height: 12), // Spasi sebelum form
                // Email Field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    style:
                        theme
                            .textTheme
                            .labelLarge, // Menggunakan gaya teks labelLarge dari TextTheme
                  ),
                ),
                const SizedBox(
                  height: 10,
                ), // Sedikit lebih banyak spasi vertikal
                TextFormField(
                  decoration: const InputDecoration(
                    hintText:
                        'Masukkan email Anda', // Perbaikan ejaan "anda" menjadi "Anda"
                  ),
                ),

                const SizedBox(height: 24), // Spasi antar field
                // Password Field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Password',
                    style:
                        theme
                            .textTheme
                            .labelLarge, // Menggunakan gaya teks labelLarge dari TextTheme
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Masukkan password Anda', // Perbaikan ejaan
                  ),
                ),
                const SizedBox(height: 6), // Spasi ke teks "Minimal 8 karakter"
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
                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        // Style akan otomatis diambil dari OutlinedButtonThemeData di ThemeData
                        child: const Text('Daftar'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Implementasi logika login
                        },
                        // Style akan otomatis diambil dari ElevatedButtonThemeData di ThemeData
                        child: const Text('Masuk'),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 48), // Spasi sebelum footer
                // Footer Text
                Text(
                  'Masuk untuk mulai memantau, mendukung, dan menyehatkan anak Indonesia.', // Teks yang lebih lengkap
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.darkText.withOpacity(
                      0.6,
                    ), // Sedikit lebih transparan dari darkText
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
