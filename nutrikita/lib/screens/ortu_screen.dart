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
              backgroundColor: Colors.green.shade200,
              foregroundColor: Colors.white,
              elevation: 0,
            )
          : null,
      backgroundColor: Colors.grey.shade100,
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
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          _buildFeedbackList(theme),
        ],
      ),
    );
  }

  Widget _buildFeedbackForm(ThemeData theme) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Kirim Feedback",
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: namaOrtuController,
              decoration: const InputDecoration(
                labelText: "Nama Orang Tua",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: sekolahAnakController,
              decoration: const InputDecoration(
                labelText: "Sekolah Anak",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: feedbackController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Feedback",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Kualitas Pelayanan",
                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: ["Sangat Baik", "Baik", "Cukup", "Kurang"]
                  .map((label) => ChoiceChip(
                        label: Text(label),
                        selected: selectedQuality == label,
                        selectedColor: Colors.green.shade200,
                        onSelected: (_) => selectQuality(label),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade200,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => submitFeedback(context),
                child: const Text("Kirim", style: TextStyle(fontSize: 16)),
              ),
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

            return ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.infinity),
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(feedback,
                            style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16)),
                        const SizedBox(height: 10),
                        Text("👤 Nama: $nama", style: theme.textTheme.bodyMedium),
                        Text("📧 Email: $email", style: theme.textTheme.bodyMedium),
                        Text("🏫 Sekolah: $sekolah", style: theme.textTheme.bodyMedium),
                        Text("⭐ Kualitas: $kualitas", style: theme.textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
