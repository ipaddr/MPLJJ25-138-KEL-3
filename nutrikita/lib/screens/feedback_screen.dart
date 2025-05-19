import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  String selectedQuality = '';
  final TextEditingController feedbackController = TextEditingController();

  void selectQuality(String quality) {
    setState(() {
      selectedQuality = quality;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5F1FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome, User!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 4),
              const Text("Pantau nutrisi anak dan tetap sehat"),
              const SizedBox(height: 24),
              const Text(
                "Feedback Tumbuh dan Gizi Anak",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: feedbackController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Tuliskan umpan balik Anda di sini...",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Contoh: Perubahan yang Anda lihat pada anak, komentar tentang program makan gratis.",
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 24),
              const Text(
                "Kualitas Makanan",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  _qualityButton("Sangat Baik"),
                  _qualityButton("Baik"),
                  _qualityButton("Cukup"),
                  _qualityButton("Kurang"),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                "Pengalaman Lain",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text("Berbagi pengalaman dan saran."),
              const SizedBox(height: 16),
              _feedbackItem("💡", "Saran", "Usulan lebih banyak sayuran."),
              const SizedBox(height: 12),
              _feedbackItem("❤️", "Testimoni", "Anak saya lebih bertenaga!"),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.blueAccent),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                    ),
                    child: const Text("Batal"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Kirim feedback ke backend (contoh)
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
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                    ),
                    child: const Text("Kirim Feedback"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _qualityButton(String label) {
    bool isSelected = selectedQuality == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: Colors.blueAccent,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black87,
      ),
      onSelected: (_) => selectQuality(label),
    );
  }

  Widget _feedbackItem(String emoji, String title, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
              Text(text),
            ],
          ),
        ),
      ],
    );
  }
}
