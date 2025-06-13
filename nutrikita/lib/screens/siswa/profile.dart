import 'package:flutter/material.dart';
import 'input_data_siswa.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool showTantangan = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFA8D5BA),
        title: const Text(
          'Profil Siswa',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 12),
            const Text(
              'Nama Siswa',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InputDataSiswaScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text('Perbarui Data Fisik'),
            ),
            const SizedBox(height: 20),

            // Tab Tantangan & Pencapaian (ganti konten, bukan halaman)
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          showTantangan = true;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: showTantangan ? Colors.grey[300] : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Tantangan',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: showTantangan ? Colors.black : Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          showTantangan = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: !showTantangan ? Colors.grey[300] : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Pencapaian',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: !showTantangan ? Colors.black : Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            showTantangan ? _buildTantangan() : _buildPencapaian(),
          ],
        ),
      ),
    );
  }

  Widget _buildTantangan() {
    return Column(
      children: [
        _buildChallengeCard('Tantangan Mingguan', [
          'Konsumsi Sayur 2x Sehari',
          'Hindari Minuman Manis 5 Hari',
          'Makan Nasi Merah 2x Seminggu',
          'Coba Resep Salad Sendiri',
        ]),
        const SizedBox(height: 16),
        _buildChallengeCard('Tantangan Harian', [
          'Minum Air Putih 8 Gelas',
          'Tambahkan Buah Saat Sarapan',
          'Tanpa Gorengan Hari Ini',
          'Makan Tepat Waktu 3x',
        ]),
      ],
    );
  }

  Widget _buildPencapaian() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Lencana Terbaik", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(3, (index) {
            return const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey,
            );
          }),
        ),
        const SizedBox(height: 24),
        const Text("Pencapaian Lainnya", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(12, (index) {
            return const CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey,
            );
          }),
        ),
      ],
    );
  }

  Widget _buildChallengeCard(String title, List<String> items) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          ...items.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  const Icon(Icons.radio_button_unchecked, size: 20),
                  const SizedBox(width: 8),
                  Expanded(child: Text(e)),
                ],
              ),
            ),
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Lainnya ⬆',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
