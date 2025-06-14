import 'package:flutter/material.dart';

class PemerintahScreen extends StatelessWidget {
  const PemerintahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: const Text('Dashboard Nasional'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Keluar',
            onPressed: () {
              // Navigasi ke halaman login / logout logic
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== Program Gizi Nasional =====
              Text(
                'Program Gizi Nasional',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoCard(
                      theme,
                      iconPath: 'assets/icons/siswa.png',
                      value: '52.913.427',
                      label: 'Jumlah Anak',
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildInfoCard(
                      theme,
                      iconPath: 'assets/icons/sekolah.png',
                      value: '400.000',
                      label: 'Jumlah Sekolah',
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: _buildInfoCard(
                  theme,
                  iconPath: 'assets/icons/laporan.png',
                  value: '100.000',
                  label: 'Laporan Masuk',
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 32),

              // ===== Status Umum Gizi Nasional =====
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/icons/status.png', height: 28),
                          const SizedBox(width: 8),
                          Text(
                            'Status Umum Gizi Nasional',
                            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      _giziStatusItem(theme, '🔴 Buruk', '5%'),
                      _giziStatusItem(theme, '🟠 Kurang', '35%'),
                      _giziStatusItem(theme, '🟢 Baik', '60%'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // ===== Notifikasi Penting =====
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/icons/peringatan.png', height: 24),
                          const SizedBox(width: 8),
                          Text(
                            'Notifikasi Penting',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.error,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      _notifikasiItem(theme, '⚠️ Kab. Solok: Lonjakan gizi buruk minggu ini'),
                      _notifikasiItem(theme, '📌 SDN 12 belum mengirim data 3 hari'),
                      _notifikasiItem(theme, '🥦 Konsumsi sayur meningkat 8% minggu ini'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: theme.colorScheme.onSurfaceVariant,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Akun'),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/akun');
          }
        },
      ),
    );
  }

  Widget _buildInfoCard(
    ThemeData theme, {
    required String iconPath,
    required String value,
    required String label,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Column(
          children: [
            Image.asset(iconPath, height: 36),
            const SizedBox(height: 12),
            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _giziStatusItem(ThemeData theme, String kategori, String persen) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(kategori, style: theme.textTheme.bodyLarge),
          Text(persen, style: theme.textTheme.bodyLarge),
        ],
      ),
    );
  }

  Widget _notifikasiItem(ThemeData theme, String pesan) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        pesan,
        style: theme.textTheme.bodyMedium,
      ),
    );
  }
}
