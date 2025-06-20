import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'utils/app_theme.dart';

import 'screens/welcome_screen.dart';
import 'services/login_screen.dart';
import 'services/register_screen.dart';
import 'screens/siswa/dashboard.dart';
import 'screens/siswa/input_makanan.dart';
import 'screens/siswa/articles.dart';
import 'screens/siswa/article_detail.dart';
import 'screens/siswa/profile.dart';

import 'screens/pemerintah_screen.dart';
import 'screens/sekolah_screen.dart';
import 'screens/ortu_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutriKita App',
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/siswa': (context) => const DashboardScreen(), // ← perbaikan
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
        '/pemerintah': (context) => const PemerintahScreen(),
        '/sekolah': (context) => const SekolahScreen(),
        '/ortu': (context) => const OrtuScreen(),
      },
    );
  }
}
