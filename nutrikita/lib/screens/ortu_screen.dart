import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widget/bottom_nav_bar.dart';
import '../screens/profile.dart';

class OrtuScreen extends StatefulWidget {
  const OrtuScreen({super.key});

  @override
  State<OrtuScreen> createState() => _OrtuScreenState();
}

class _OrtuScreenState extends State<OrtuScreen> {
  final TextEditingController feedbackController = TextEditingController();
  final TextEditingController namaOrtuController = TextEditingController();
  final TextEditingController sekolahAnakController = TextEditingController();
  String selectedQuality = '';
  int _selectedIndex = 0;

  void selectQuality(String quality) {
    setState(() {
      selectedQuality = quality;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> submitFeedback(BuildContext context) async {
    if (feedbackController.text.isEmpty ||
        selectedQuality.isEmpty ||
        namaOrtuController.text.isEmpty ||
        sekolahAnakController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lengkapi semua bagian sebelum mengirim.")),
      );
      return;
    }

    final user = FirebaseAuth.instance.currentUser;

    try {
      await FirebaseFirestore.instance.collection('feedback_ortu').add({
        'feedback': feedbackController.text,
        'kualitas': selectedQuality,
        'tanggal': Timestamp.now(),
        'nama': namaOrtuController.text,
        'sekolah': sekolahAnakController.text,
        'email': user?.email ?? 'anonim',
      });

      feedbackController.clear();
      namaOrtuController.clear();
      sekolahAnakController.clear();
      selectedQuality = '';
      setState(() {});

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Feedback Dikirim"),
          content: const Text("Terima kasih atas masukan Anda."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal mengirim feedback: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pages = [
      _buildHomeContent(theme),
      const ProfileScreen(),
    ];

    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
              title: const Text("Beranda Orang Tua"),
              backgroundColor: theme.colorScheme.background,
              foregroundColor: theme.colorScheme.onBackground,
              elevation: 0,
            )
          : null,
      backgroundColor: theme.scaffoldBackgroundColor,
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildHomeContent(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFeedbackForm(theme),
          const SizedBox(height: 24),
          Text(
            "Feedback Orang Tua Lain",
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildFeedbackList(theme),
        ],
      ),
    );
  }

  Widget _buildFeedbackForm(ThemeData theme) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Kirim Feedback",
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: namaOrtuController,
              decoration: const InputDecoration(labelText: "Nama Orang Tua"),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: sekolahAnakController,
              decoration: const InputDecoration(labelText: "Sekolah Anak"),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: feedbackController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: "Feedback"),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: ["Sangat Baik", "Baik", "Cukup", "Kurang"]
                  .map((label) => ChoiceChip(
                        label: Text(label),
                        selected: selectedQuality == label,
                        onSelected: (_) => selectQuality(label),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => submitFeedback(context),
              child: const Text("Kirim"),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackList(ThemeData theme) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('feedback_ortu')
          .orderBy('tanggal', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final docs = snapshot.data!.docs;

        return Column(
          children: docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final feedback = data['feedback'] ?? '-';
            final nama = data['nama'] ?? '';
            final email = data['email'] ?? '';
            final sekolah = data['sekolah'] ?? '';
            final kualitas = data['kualitas'] ?? '';

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feedback,
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 8),
                    if (nama.isNotEmpty) Text("Nama: $nama"),
                    if (email.isNotEmpty) Text("Email: $email"),
                    if (sekolah.isNotEmpty) Text("Sekolah: $sekolah"),
                    if (kualitas.isNotEmpty) Text("Kualitas: $kualitas"),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
