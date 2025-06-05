import 'package:flutter/material.dart';
// Tidak perlu lagi mengimpor app_colors.dart secara langsung di sini,
// karena semua warna sudah diakses melalui Theme.of(context).colorScheme
// atau theme.textTheme.style?.copyWith()
// import '../utils/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset('assets/logos/nutrikita.png', height: 300),
              const SizedBox(height: 16),

              // Teks 'Selamat Datang Di NutriKita'
              // Gunakan gaya dari theme.textTheme yang paling sesuai
              Text(
                'Selamat Datang Di NutriKita \n Bersama Membantu Tumbuh Kembang Anak',
                textAlign: TextAlign.center,
                // Menggunakan headlineSmall atau titleLarge/medium tergantung ukuran yang diinginkan
                // Mengambil warna dari colorScheme.onBackground (warna teks di atas background)
                style: theme.textTheme.headlineSmall?.copyWith(
                  color:
                      theme.colorScheme.onBackground, // Ambil warna dari tema
                  // Hapus fontSize dan fontWeight manual karena sudah diatur di theme.textTheme
                  // fontSize: 12, // Ini akan meng-override yang di tema, sebaiknya hindari jika sudah diatur
                ),
              ),
              const SizedBox(height: 40), // Pertahankan spasi ini

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text('MULAI SEKARANG'),
                ),
              ),
              const SizedBox(height: 32),
              // Teks 'Bersama Indonesia Tumbuh, Cerdas, dan Hidup Bahagia'
              // Gunakan gaya dari theme.textTheme yang paling sesuai (bodySmall)
              Text(
                'Bersama Indonesia Tumbuh, Cerdas, dan Hidup Bahagia',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  // Menggunakan warna onBackground atau onSurfaceVariant untuk teks sekunder
                  color: theme.colorScheme.onBackground.withOpacity(
                    0.6,
                  ), // Ambil warna dari tema
                  // Hapus fontSize manual karena sudah diatur di theme.textTheme
                  // fontSize: 10, // Ini akan meng-override yang di tema
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
