import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset('assets/logos/nutrikita.png', height: 300),
              const SizedBox(height: 16),

              const SizedBox(height: 24),
              Text(
                'Selamat Datang Di NutriKita \n Bersama Membantu Tumbuh Kembang Anak',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.darkText,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 40),

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
              Text(
                'Bersama Indonesia Tumbuh, Cerdas, dan Hidup Bahagia',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.darkText.withOpacity(0.6),
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
