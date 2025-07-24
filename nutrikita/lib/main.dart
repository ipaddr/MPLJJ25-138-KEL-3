import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'utils/app_theme.dart';

// Services
import 'services/welcome_screen.dart';
import 'services/login_screen.dart';
import 'services/register_screen.dart';

// Siswa Screens
import 'screens/siswa/dashboard.dart';
import 'screens/siswa/input_makanan.dart';
import 'screens/siswa/articles.dart';
import 'screens/siswa/article_detail.dart';

// Umum
import 'screens/profile.dart';
import 'screens/input_artikel_screen.dart';

// Role-Based Screens
import 'screens/pemerintah_screen.dart';
import 'screens/sekolah_screen.dart';
import 'screens/ortu_screen.dart';

// AI Fitur
import 'screens/seed_rekomendasi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutriKita App',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),

        // Siswa Routes
        '/dashboard': (context) => const DashboardScreen(),
        '/siswa': (context) => const DashboardScreen(),
        '/input_makanan': (context) => const InputMakananScreen(),
        '/articles': (context) => const ArticlesScreen(),
        '/article_detail': (context) => const ArticleDetailScreen(
              title: 'Judul Artikel',
              content: 'Isi artikel...',
              date: '2025-01-01',
              tags: ['Contoh'],
              imageUrl: null,
            ),

        // Umum
        '/input_artikel': (context) => const InputArtikelScreen(),
        '/profile': (context) => const ProfileScreen(),

        // Role-Based
        '/pemerintah': (context) => const PemerintahScreen(),
        '/sekolah': (context) => const SekolahScreen(),
        '/ortu': (context) => const OrtuScreen(),

        // Fitur AI
        '/seed_rekomendasi': (context) => const SeedRekomendasiScreen(),
      },
    );
  }
}
