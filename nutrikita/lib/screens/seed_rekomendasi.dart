import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SeedRekomendasiScreen extends StatelessWidget {
  const SeedRekomendasiScreen({super.key});

  final List<Map<String, String>> _data = const [
    {
      "judul": "Nasi Merah dengan Ayam Panggang",
      "deskripsi": "Kaya serat dan protein, cocok untuk makan siang sehat.",
    },
    {
      "judul": "Smoothie Pisang dan Oat",
      "deskripsi": "Minuman energi pagi hari yang sehat dan mengenyangkan.",
    },
    {
      "judul": "Sup Brokoli dan Wortel",
      "deskripsi": "Tinggi vitamin dan rendah kalori.",
    },
    {
      "judul": "Tahu Lada Hitam",
      "deskripsi": "Sumber protein nabati yang lezat.",
    },
    {
      "judul": "Ikan Bakar dengan Sambal Dabu-dabu",
      "deskripsi": "Kaya omega-3 dan rendah lemak jenuh.",
    },
    {
      "judul": "Roti Gandum dan Telur Rebus",
      "deskripsi": "Cocok untuk sarapan sehat dan cepat.",
    },
    {
      "judul": "Sayur Asem dan Tempe Goreng",
      "deskripsi": "Lauk sehat dan nikmat untuk makan siang.",
    },
    {
      "judul": "Salad Buah Yogurt",
      "deskripsi": "Segar, kaya serat dan vitamin.",
    },
    {
      "judul": "Mie Shirataki Tumis Sayur",
      "deskripsi": "Alternatif mie rendah kalori.",
    },
    {
      "judul": "Sereal Gandum dan Susu",
      "deskripsi": "Energi pagi untuk anak sekolah.",
    },
    {
      "judul": "Ubi Kukus dan Telur Dadar",
      "deskripsi": "Kombinasi karbohidrat kompleks dan protein.",
    },
    {
      "judul": "Omelet Sayur",
      "deskripsi": "Sarapan sehat penuh nutrisi.",
    },
    {
      "judul": "Tumis Kangkung dan Nasi Merah",
      "deskripsi": "Rendah kolesterol dan kaya zat besi.",
    },
    {
      "judul": "Tumis Buncis dan Wortel",
      "deskripsi": "Sayur tumis sederhana namun kaya vitamin.",
    },
    {
      "judul": "Sate Tempe",
      "deskripsi": "Alternatif sate sehat dan hemat.",
    },
    {
      "judul": "Bubur Kacang Hijau",
      "deskripsi": "Camilan sehat dan mengenyangkan.",
    },
    {
      "judul": "Tumis Jamur Tiram",
      "deskripsi": "Rendah kalori dan tinggi protein nabati.",
    },
    {
      "judul": "Pisang dan Susu Kedelai",
      "deskripsi": "Camilan sore sehat tanpa gula tambahan.",
    },
    {
      "judul": "Lontong Sayur",
      "deskripsi": "Makanan tradisional dengan sayuran sehat.",
    },
    {
      "judul": "Sandwich Gandum Isi Telur dan Tomat",
      "deskripsi": "Praktis untuk bekal anak.",
    },
  ];

  Future<void> _seedData(BuildContext context) async {
    final batch = FirebaseFirestore.instance.batch();
    final collection = FirebaseFirestore.instance.collection('rekomendasi_makanan');

    for (var item in _data) {
      final doc = collection.doc();
      batch.set(doc, item);
    }

    try {
      await batch.commit();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Berhasil menambahkan 20 rekomendasi makanan!")),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Gagal menambahkan data: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Seed Rekomendasi Makanan")),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => _seedData(context),
          icon: const Icon(Icons.cloud_upload),
          label: const Text("Kirim 20 Rekomendasi ke Firestore"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ),
      ),
    );
  }
}
