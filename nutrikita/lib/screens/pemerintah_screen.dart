import 'package:flutter/material.dart';

class DashboardPemerintahScreen extends StatelessWidget {
  const DashboardPemerintahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5F1FB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Dashboard Nasional',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            'Program Gizi',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/logo/logonutrikita.png',
                      height: 60, // dibesarkan
                    ),
                  ],
                ),
              ),

              // Garis pembatas
              const Divider(
                color: Colors.black26,
                thickness: 1,
                height: 10,
              ),

              const SizedBox(height: 8),

              // Cards Baris Pertama
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _buildInfoCard('assets/ikon/ikon_siswa.png', '52.913.427', 'Jumlah Anak'),
                    _buildInfoCard('assets/ikon/ikon_sekolah.png', '400.000', 'Jumlah Sekolah'),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Card Laporan Masuk di tengah
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: _buildInfoCard('assets/ikon/ikon_laporan.png', '100.000', 'Laporan Masuk'),
                ),
              ),

              const SizedBox(height: 24),

              // Status Gizi Nasional dengan ikon besar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/ikon/ikon_status.png',
                      height: 48,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Status Umum Gizi Nasional',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Persentase status gizi
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('🔴 Buruk: 5%'),
                    Text('🟠 Kurang: 35%'),
                    Text('🟢 Baik: 60%'),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Notifikasi Penting
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/ikon/ikon_peringatan.png', height: 24),
                          const SizedBox(width: 8),
                          const Text(
                            'Notifikasi Penting',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text('⚠️ Kab. Solok: Lonjakan gizi buruk minggu ini'),
                      const Text('📌 Sekolah SDN 12 belum mengirim data 3 hari'),
                      const Text('🥦 Tingkat konsumsi sayur meningkat 8% minggu ini'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), 
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/akun');
          }
        },
      ),
    );
  }

  // Komponen kartu info
  Widget _buildInfoCard(String iconPath, String value, String label) {
    return SizedBox(
      width: 150,
      height: 120,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, height: 36),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
