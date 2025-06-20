import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/buttons.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? nama;
  String? email;
  String? role;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
      setState(() {
        nama = doc.data()?['nama'] ?? '-';
        email = doc.data()?['email'] ?? user.email ?? '-';
        role = doc.data()?['role'] ?? '-';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFA8D5BA),
        title: const Text('Profil', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Keluar',
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('Konfirmasi Keluar'),
                      content: const Text(
                        'Apakah Anda yakin ingin keluar dari aplikasi?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Batal'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            if (context.mounted) {
                              Navigator.popUntil(
                                context,
                                (route) => route.isFirst,
                              );
                              Navigator.pushReplacementNamed(context, '/login');
                            }
                          },
                          child: const Text('Keluar'),
                        ),
                      ],
                    ),
              );
            },
          ),
        ],
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 48,
                        backgroundColor: Colors.grey[300],
                        child: Icon(
                          Icons.person,
                          size: 48,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        nama ?? '-',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        email ?? '-',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (role != null && role != '-')
                        Chip(
                          label: Text(role!),
                          backgroundColor: const Color(0xFFA8D5BA),
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                      const SizedBox(height: 24),
                      SmallButton(
                        onPressed: () {
                          // TODO: Navigasi ke halaman edit profil jika ingin
                        },
                        icon: Icons.edit,
                        label: 'Edit Profil',
                        backgroundColor: const Color(0xFFA8D5BA),
                      ),
                      const SizedBox(height: 8),
                      SmallButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: const Text('Konfirmasi Keluar'),
                                  content: const Text(
                                    'Apakah Anda yakin ingin keluar dari aplikasi?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Batal'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await FirebaseAuth.instance.signOut();
                                        if (context.mounted) {
                                          Navigator.popUntil(
                                            context,
                                            (route) => route.isFirst,
                                          );
                                          Navigator.pushReplacementNamed(
                                            context,
                                            '/login',
                                          );
                                        }
                                      },
                                      child: const Text('Keluar'),
                                    ),
                                  ],
                                ),
                          );
                        },
                        icon: Icons.logout,
                        label: 'Logout',
                        backgroundColor: Colors.red[600]!,
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
