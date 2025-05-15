import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5F1FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE5F1FB),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo/logonutrikita.png',
                    height: 60,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'NutriKita',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Masuk Sebagai',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.6,
              children: [
                _buildRoleCard(context, 'Orang Tua'),
                _buildRoleCard(context, 'Guru'),
                _buildRoleCard(context, 'Pemerintah'),
                _buildRoleCard(context, 'Siswa'),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Pilih peran kamu',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard(BuildContext context, String role) {
    return GestureDetector(
      onTap: () {
        // Navigasi lanjut ke form register berdasarkan role (opsional)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Peran dipilih: $role')),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          role,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
