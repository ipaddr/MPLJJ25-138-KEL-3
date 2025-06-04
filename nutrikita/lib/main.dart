// File: main.dart

import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'utils/app_theme.dart';
import 'screens/siswa/dashboard.dart';

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
      // Terapkan tema dari AppTheme
      theme: AppTheme.lightTheme, // <-- Gunakan tema yang sudah dipindahkan

      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterScreen(),
        '/siswa/dashboard':
            (context) => const DashboardScreen(), // <-- Tambahkan rute ini
      },
    );
  }
}
