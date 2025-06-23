import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final namaController = TextEditingController();
  final nisnController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? selectedRole;
  final List<String> roles = ['siswa', 'sekolah', 'ortu', 'pemerintah'];

  bool isLoading = false;

  @override
  void dispose() {
    namaController.dispose();
    nisnController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final nama = namaController.text.trim();
    final nisn = nisnController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (nama.isEmpty || nisn.isEmpty || email.isEmpty || password.isEmpty || selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mohon lengkapi semua data termasuk Role')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'nama': nama,
          'nisn': nisn,
          'email': email,
          'role': selectedRole,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registrasi berhasil! Silakan login.')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registrasi gagal: ${e.toString()}')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
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
                const SizedBox(height: 24),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel(theme, 'Nama Lengkap'),
                        _buildInputField(controller: namaController, hintText: 'Masukkan nama lengkap Anda'),

                        _buildLabel(theme, 'NISN'),
                        _buildInputField(controller: nisnController, hintText: 'Masukkan NISN Anda', keyboardType: TextInputType.number),

                        _buildLabel(theme, 'Email'),
                        _buildInputField(controller: emailController, hintText: 'Masukkan email Anda', keyboardType: TextInputType.emailAddress),

                        _buildLabel(theme, 'Kata Sandi'),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(hintText: 'Buat kata sandi Anda'),
                        ),
                        const SizedBox(height: 4),
                        Text('Minimal 8 karakter', style: theme.textTheme.bodySmall),

                        const SizedBox(height: 16),
                        _buildLabel(theme, 'Pilih Role'),
                        DropdownButtonFormField<String>(
                          value: selectedRole,
                          hint: const Text('Pilih role pengguna'),
                          items: roles.map((role) => DropdownMenuItem(
                            value: role,
                            child: Text(role.toUpperCase()),
                          )).toList(),
                          onChanged: (val) => setState(() => selectedRole = val),
                          decoration: const InputDecoration(border: OutlineInputBorder()),
                        ),

                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5A3E36),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: isLoading ? null : _register,
                            child: isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text('DAFTAR SEKARANG', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Sudah punya akun? ',
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onBackground),
                      children: [
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

  Widget _buildLabel(ThemeData theme, String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Text(label, style: theme.textTheme.labelLarge),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(hintText: hintText),
      ),
    );
  }
}
