import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'utils/app_colors.dart'; // Import file warna kustom Anda

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutriKita',
      debugShowCheckedModeBanner: false,
      // Terapkan tema di sini
      theme: ThemeData(
        // Aktifkan Material 3 untuk desain modern
        useMaterial3: true,

        // --- Color Scheme ---
        // Mendefinisikan palet warna dasar untuk aplikasi.
        // Widget Material 3 akan secara otomatis menggunakan ini.
        colorScheme: ColorScheme.fromSeed(
          // Gunakan primaryGreen atau primaryBlue sebagai seed color,
          // tergantung warna mana yang ingin paling mendominasi.
          // primaryGreen akan memberikan nuansa yang lebih 'segar' dan 'alami'.
          seedColor: AppColors.primaryGreen,
          brightness: Brightness.light, // Mengatur tema terang
          primary: AppColors.primaryGreen, // Warna utama: Hijau Muda
          onPrimary: AppColors.white, // Teks/ikon di atas primary: Putih
          secondary:
              AppColors
                  .primaryBlue, // Warna sekunder: Biru Langit (untuk aksen lain)
          onSecondary: AppColors.white,
          tertiary:
              AppColors
                  .secondaryYellow, // Warna tersier: Kuning Terang (untuk aksen ceria)
          onTertiary: AppColors.darkText,
          surface: AppColors.white, // Warna permukaan (card, dialog): Putih
          onSurface:
              AppColors.darkText, // Teks/ikon di atas surface: Abu-abu Tua
          background:
              AppColors
                  .lightGreyBackground, // Latar belakang utama: Abu-abu Muda
          onBackground:
              AppColors.darkText, // Teks/ikon di atas background: Abu-abu Tua
          error:
              AppColors
                  .accentRedWarning, // Warna untuk error/peringatan: Merah Kecil
          onError: AppColors.white,
          // Tambahkan juga warna lain dari palet Anda ke ColorScheme jika ingin Material 3 menggunakannya secara otomatis
          // Contoh:
          // primaryContainer: AppColors.primaryGreen.withOpacity(0.2),
          // onPrimaryContainer: AppColors.darkText,
          // secondaryContainer: AppColors.primaryBlue.withOpacity(0.2),
          // onSecondaryContainer: AppColors.darkText,
        ),

        // --- Scaffold Background ---
        // Mengatur warna latar belakang default untuk semua Scaffold
        scaffoldBackgroundColor: AppColors.lightGreyBackground,

        // --- AppBar Theme ---
        appBarTheme: AppBarTheme(
          // Menggunakan primaryGreen sebagai latar belakang AppBar untuk konsistensi
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: AppColors.white, // Warna ikon dan teks judul AppBar
          elevation: 0, // Tanpa bayangan
          iconTheme: const IconThemeData(
            color: AppColors.white, // Warna ikon AppBar
          ),
          titleTextStyle: const TextStyle(
            color: AppColors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ), // Gaya teks judul AppBar
        ),

        // --- ElevatedButton Theme ---
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            // Menggunakan secondaryOrange untuk tombol CTA utama agar menonjol
            backgroundColor: AppColors.secondaryOrange,
            foregroundColor: AppColors.white, // Warna teks/ikon default
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ), // Padding lebih besar
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Sudut lebih membulat
            ),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16, // Ukuran teks lebih besar
            ),
            // Menggunakan bayangan yang lebih lembut
            shadowColor: AppColors.secondaryOrange.withOpacity(0.4),
            elevation: 4,
          ),
        ),

        // --- OutlinedButton Theme ---
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color:
                  AppColors.primaryGreen, // Warna border default: primaryGreen
              width: 1.5, // Border sedikit lebih tebal
            ),
            foregroundColor: AppColors.primaryGreen, // Warna teks/ikon default
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),

        // --- InputDecoration (untuk TextFormField) Theme ---
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
            color: AppColors.greyText.withOpacity(0.7), // Gaya teks hint
          ),
          fillColor: AppColors.white, // Warna isi field
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18, // Padding horizontal sedikit lebih besar
            vertical: 14, // Padding vertical sedikit lebih besar
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), // Sudut lebih membulat
            borderSide: BorderSide(
              color: AppColors.mediumLightGrey, // Warna border default
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColors.mediumLightGrey, // Warna border saat tidak fokus
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color:
                  AppColors.primaryBlue, // Warna border saat fokus: Biru Langit
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color:
                  AppColors
                      .accentRedWarning, // Warna border saat error: Merah Kecil
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.accentRedWarning, width: 2),
          ),
          // Tambahkan labelStyle jika Anda menggunakan label di TextFormField
          labelStyle: const TextStyle(color: AppColors.darkText),
        ),

        // --- Text Theme ---
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: AppColors.darkText),
          displayMedium: TextStyle(color: AppColors.darkText),
          displaySmall: TextStyle(color: AppColors.darkText),
          headlineLarge: TextStyle(color: AppColors.darkText),
          headlineMedium: TextStyle(color: AppColors.darkText),
          headlineSmall: TextStyle(color: AppColors.darkText),
          titleLarge: TextStyle(
            color: AppColors.darkText,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(color: AppColors.darkText),
          titleSmall: TextStyle(color: AppColors.darkText),
          bodyLarge: TextStyle(color: AppColors.darkText),
          bodyMedium: TextStyle(color: AppColors.darkText),
          bodySmall: TextStyle(
            color: AppColors.greyText,
          ), // Untuk teks yang lebih kecil/sekunder
          labelLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.darkText,
          ), // Untuk label input field atau tombol
          // Anda bisa menambahkan gaya teks lainnya sesuai kebutuhan Material 3
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}
