import 'package:flutter/material.dart';

class PemerintahScreen extends StatelessWidget {
  const PemerintahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              floating: true,
              pinned: true,
              snap: true,
              expandedHeight: 120,
              backgroundColor: theme.scaffoldBackgroundColor,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: const EdgeInsets.only(left: 24.0, bottom: 32.0),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        'Dashboard Nasional',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Info utama dalam Card (full width)
                    Card(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Program Gizi Nasional',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Baris atas: 2 card
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
                            // Baris bawah: 1 card di tengah
                            Row(
                              children: [
                                const Spacer(),
                                Expanded(
                                  flex: 2,
                                  child: _buildInfoCard(
                                    theme,
                                    iconPath: 'assets/icons/laporan.png',
                                    value: '100.000',
                                    label: 'Laporan Masuk',
                                    color: Colors.green,
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Status Gizi Nasional
                    Card(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/status.png',
                                  height: 36,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Status Umum Gizi Nasional',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '🔴 Buruk: 5%',
                              style: theme.textTheme.bodyMedium,
                            ),
                            Text(
                              '🟠 Kurang: 35%',
                              style: theme.textTheme.bodyMedium,
                            ),
                            Text(
                              '🟢 Baik: 60%',
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Notifikasi Penting
                    Card(
                      margin: EdgeInsets.zero,
                      color: theme.colorScheme.surface,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/peringatan.png',
                                  height: 24,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Notifikasi Penting',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '⚠️ Kab. Solok: Lonjakan gizi buruk minggu ini',
                              style: theme.textTheme.bodyMedium,
                            ),
                            Text(
                              '📌 Sekolah SDN 12 belum mengirim data 3 hari',
                              style: theme.textTheme.bodyMedium,
                            ),
                            Text(
                              '🥦 Tingkat konsumsi sayur meningkat 8% minggu ini',
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: theme.colorScheme.onSurfaceVariant,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          Text(
            label,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
