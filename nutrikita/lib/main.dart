// File: main.dart
import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

import '../screens/welcome_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/siswa/dashboard.dart';
import '../screens/siswa/input_makanan.dart';
import '../screens/siswa/articles.dart';
import '../screens/siswa/article_detail.dart';
import '../screens/siswa/profile.dart';

import '../screens/pemerintah_screen.dart';
import '../screens/sekolah_screen.dart';
import '../screens/feedback_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutriKita App',
      theme: AppTheme.lightTheme,
      initialRoute: '/', // Aplikasi akan dimulai dari rute '/'

      routes: {
        '/':
            (context) =>
                const WelcomeScreen(), // Rute awal Anda adalah WelcomeScreen
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/input_makanan': (context) => const InputMakananScreen(),
        '/articles': (context) => const ArticlesScreen(),
        '/article_detail':
            (context) => ArticleDetailScreen(
              title: 'Judul Artikel',
              content: 'Konten artikel di sini...',
              date: '1 Januari 2023',
              tags: ['Tag1', 'Tag2'],
            ),
        '/profile': (context) => const ProfileScreen(),

        '../pemerintah_screen.dart': (context) => const PemerintahScreen(),
        '../sekolah_screen.dart': (context) => const SekolahScreen(),
        '../feedback_screen.dart': (context) => const FeedbackScreen(),
      },
    );
  }
}
