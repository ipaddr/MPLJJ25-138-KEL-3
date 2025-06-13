// File: screens/login_screen.dart

import 'package:flutter/material.dart';
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
        // titleTextStyle akan otomatis diambil dari appBarTheme di AppTheme
        title: const Text('Masuk'), // Cukup teks saja, gaya dari tema
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
                        // Email Field
                        Text(
                          'Email',
                          style: theme.textTheme.labelLarge,
                        ), // Menggunakan gaya dari tema
                        const SizedBox(height: 8),
                        TextFormField(
                          // InputDecoration akan otomatis mengambil gaya dari inputDecorationTheme di AppTheme
                          decoration: const InputDecoration(
                            hintText: 'Masukkan email Anda',
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Password Field
                        Text(
                          'Password',
                          style: theme.textTheme.labelLarge,
                        ), // Menggunakan gaya dari tema
                        const SizedBox(height: 8),
                        TextFormField(
                          obscureText: true,
                          // InputDecoration akan otomatis mengambil gaya dari inputDecorationTheme di AppTheme
                          decoration: const InputDecoration(
                            hintText: 'Masukkan password Anda',
                          ),
                        ),
                        const SizedBox(height: 4),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Minimal 8 karakter',
                              style:
                                  theme
                                      .textTheme
                                      .bodySmall, // Menggunakan gaya dari tema
                            ),
                            TextButton(
                              onPressed: () {
                                // TODO: Implementasi lupa password
                              },
                              // TextButton akan otomatis mengambil gaya dari textButtonTheme di AppTheme
                              // (padding, minimumSize, tapTargetSize, foregroundColor, textStyle)
                              // Jadi, tidak perlu lagi mengaturnya secara manual di sini:
                              // style: TextButton.styleFrom(
                              //   padding: EdgeInsets.zero,
                              //   minimumSize: Size.zero,
                              //   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              // ),
                              child: Text(
                                'Lupa Password',
                                // Gaya teks sudah diatur di textButtonTheme,
                                // Tapi jika ingin override warna & ketebalan, gunakan copyWith
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // Tombol Masuk
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                // '/dashboard',
                                '../pemerintah_screen.dart',
                              );
                            },
                            child: const Text('Masuk'),
                          ),
                        ),

                        const SizedBox(height: 32),

                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color:
                                    theme
                                        .colorScheme
                                        .outlineVariant, // Menggunakan warna dari tema
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Text(
                                'Masuk dengan',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color:
                                      theme
                                          .colorScheme
                                          .onSurfaceVariant, // Menggunakan warna dari tema
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color:
                                    theme
                                        .colorScheme
                                        .outlineVariant, // Menggunakan warna dari tema
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Tombol Google Sign-in
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // TODO: Implementasi login dengan Google
                            },
                            // OutlinedButton akan otomatis mengambil gaya dari outlinedButtonTheme di AppTheme
                            // (side, foregroundColor, padding, shape, textStyle)
                            // Jadi, tidak perlu lagi mengaturnya secara manual di sini:
                            // style: OutlinedButton.styleFrom(
                            //   padding: const EdgeInsets.symmetric(vertical: 14),
                            //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            //   side: BorderSide(color: theme.colorScheme.outline, width: 1.5),
                            //   foregroundColor: theme.colorScheme.onSurface,
                            // ),
                            icon: Image.asset(
                              'assets/logos/google.png',
                              height: 24,
                            ),
                            label: Text(
                              'Google',
                              // Gaya teks sudah diatur di outlinedButtonTheme,
                              // tapi jika ada perbedaan khusus di sini, gunakan copyWith:
                              style:
                                  theme
                                      .textTheme
                                      .labelLarge, // Menggunakan gaya dari tema
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  // TextButton akan otomatis mengambil gaya dari textButtonTheme di AppTheme
                  // (foregroundColor, padding, textStyle)
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Belum punya akun? ',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color:
                            theme
                                .colorScheme
                                .onBackground, // Menggunakan warna dari tema
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Daftar disini',
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
