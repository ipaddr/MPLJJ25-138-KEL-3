import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar', style: theme.appBarTheme.titleTextStyle),
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
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  color: theme.colorScheme.surface,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nama Field
                        Text('Nama Lengkap', style: theme.textTheme.labelLarge),
                        const SizedBox(height: 12),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Masukkan nama lengkap Anda',
                          ),
                        ),
                        const SizedBox(height: 8),

                        Text('NISN', style: theme.textTheme.labelLarge),
                        const SizedBox(height: 8),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Masukkan NISN Anda',
                          ),
                        ),
                        const SizedBox(height: 8),

                        Text('Email', style: theme.textTheme.labelLarge),
                        const SizedBox(height: 8),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'Masukkan email Anda',
                          ),
                        ),
                        const SizedBox(height: 8),

                        Text('Kata Sandi', style: theme.textTheme.labelLarge),
                        const SizedBox(height: 8),
                        TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Buat kata sandi Anda',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Minimal 8 karakter',
                            style: theme.textTheme.bodySmall,
                          ),
                        ),

                        const SizedBox(height: 32),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // TODO: Implementasi logika pendaftaran di sini

                              Navigator.pop(context);
                            },

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
                    Navigator.pop(context);
                  },
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Sudah punya akun? ',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onBackground,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Masuk disini',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
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
