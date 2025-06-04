import 'package:flutter/material.dart';
// Tidak perlu lagi mengimpor app_colors.dart secara langsung di sini,
// karena semua warna sudah diakses melalui Theme.of(context).colorScheme
// import '../utils/app_colors.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      // Scaffold background color akan otomatis dari theme.scaffoldBackgroundColor
      appBar: AppBar(
        // titleTextStyle akan otomatis diambil dari appBarTheme di AppTheme
        title: const Text('Daftar'), // Cukup teks saja, gaya dari tema
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
                Image.asset('assets/logos/nutrikita.png', height: 120),
                const SizedBox(height: 8),

                Card(
                  // Card akan otomatis mengambil gaya dari cardTheme di AppTheme
                  // (margin, shape, elevation, color sudah diatur di tema)
                  // Jadi, tidak perlu lagi mengaturnya secara manual di sini:
                  // margin: EdgeInsets.zero,
                  // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  // elevation: 4,
                  // color: theme.colorScheme.surface, // ini sudah diatur di CardTheme.color
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nama Field
                        Text(
                          'Nama Lengkap',
                          style: theme.textTheme.labelLarge,
                        ), // Menggunakan gaya dari tema
                        const SizedBox(height: 12),
                        TextFormField(
                          // InputDecoration akan otomatis mengambil gaya dari inputDecorationTheme di AppTheme
                          decoration: const InputDecoration(
                            hintText: 'Masukkan nama lengkap Anda',
                          ),
                        ),
                        const SizedBox(height: 8),

                        Text(
                          'NISN',
                          style: theme.textTheme.labelLarge,
                        ), // Menggunakan gaya dari tema
                        const SizedBox(height: 8),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          // InputDecoration akan otomatis mengambil gaya dari inputDecorationTheme di AppTheme
                          decoration: const InputDecoration(
                            hintText: 'Masukkan NISN Anda',
                          ),
                        ),
                        const SizedBox(height: 8),

                        Text(
                          'Email',
                          style: theme.textTheme.labelLarge,
                        ), // Menggunakan gaya dari tema
                        const SizedBox(height: 8),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          // InputDecoration akan otomatis mengambil gaya dari inputDecorationTheme di AppTheme
                          decoration: const InputDecoration(
                            hintText: 'Masukkan email Anda',
                          ),
                        ),
                        const SizedBox(height: 8),

                        Text(
                          'Kata Sandi',
                          style: theme.textTheme.labelLarge,
                        ), // Menggunakan gaya dari tema
                        const SizedBox(height: 8),
                        TextFormField(
                          obscureText: true,
                          // InputDecoration akan otomatis mengambil gaya dari inputDecorationTheme di AppTheme
                          decoration: const InputDecoration(
                            hintText: 'Buat kata sandi Anda',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Minimal 8 karakter',
                            style:
                                theme
                                    .textTheme
                                    .bodySmall, // Menggunakan gaya dari tema
                          ),
                        ),

                        const SizedBox(height: 32),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // TODO: Implementasi logika pendaftaran di sini

                              // Navigasi kembali ke halaman sebelumnya (misalnya LoginScreen)
                              Navigator.pop(context);
                            },
                            // ElevatedButton akan otomatis mengambil gaya dari elevatedButtonTheme di AppTheme
                            // (backgroundColor, foregroundColor, padding, shape, textStyle, shadowColor, elevation)
                            child: const Text('DAFTAR SEKARANG'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Kembali ke halaman sebelumnya
                  },
                  // TextButton akan otomatis mengambil gaya dari textButtonTheme di AppTheme
                  // (foregroundColor, padding, textStyle)
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Sudah punya akun? ',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color:
                            theme
                                .colorScheme
                                .onBackground, // Menggunakan warna dari tema
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Masuk disini',
                          // Gaya teks sudah diatur di textButtonTheme,
                          // tapi jika ingin override warna & ketebalan, gunakan copyWith:
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color:
                                theme
                                    .colorScheme
                                    .primary, // Menggunakan warna dari tema
                            fontWeight:
                                FontWeight
                                    .bold, // Menggunakan ketebalan dari tema
                          ),
                        ),
                      ],
                    ),
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
