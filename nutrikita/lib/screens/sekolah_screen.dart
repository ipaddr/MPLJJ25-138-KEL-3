import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../screens/profile.dart';
import 'input_artikel_screen.dart';

class SekolahScreen extends StatefulWidget {
  const SekolahScreen({super.key});

  @override
  State<SekolahScreen> createState() => _SekolahScreenState();
}

class _SekolahScreenState extends State<SekolahScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const _SekolahDashboardContent(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: _selectedIndex == 0
          ? AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: theme.scaffoldBackgroundColor,
              elevation: 0,
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Keluar',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Konfirmasi Keluar'),
                        content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Batal'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              if (context.mounted) {
                                Navigator.popUntil(context, (route) => route.isFirst);
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
              title: Text(
                'Dashboard Sekolah',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: theme.colorScheme.onBackground,
                ),
              ),
            )
          : null,
      body: IndexedStack(index: _selectedIndex, children: _widgetOptions),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InputArtikelScreen()),
          );
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.post_add),
        tooltip: 'Tambah Artikel',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home),
                color: _selectedIndex == 0 ? Colors.teal : Colors.grey,
                onPressed: () => _onItemTapped(0),
              ),
              const SizedBox(width: 40),
              IconButton(
                icon: const Icon(Icons.person),
                color: _selectedIndex == 1 ? Colors.teal : Colors.grey,
                onPressed: () => _onItemTapped(1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SekolahDashboardContent extends StatefulWidget {
  const _SekolahDashboardContent();

  @override
  State<_SekolahDashboardContent> createState() => _SekolahDashboardContentState();
}

class _SekolahDashboardContentState extends State<_SekolahDashboardContent> {
  int totalInput = 0;
  int sehatCount = 0;
  int tidakSehatCount = 0;
  double protein = 0.6;
  double lemak = 0.4;
  double karbo = 0.5;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final snapshot = await FirebaseFirestore.instance.collection('input_makanan').get();
    final data = snapshot.docs;
    int sehat = 0;
    int tidakSehat = 0;

    for (var doc in data) {
      final catatan = doc['catatan']?.toString().toLowerCase() ?? '';
      if (catatan.contains('sehat') || catatan.contains('bergizi')) {
        sehat++;
      } else {
        tidakSehat++;
      }
    }

    setState(() {
      totalInput = data.length;
      sehatCount = sehat;
      tidakSehatCount = tidakSehat;
      protein = sehat / (sehat + tidakSehat + 1);
      lemak = tidakSehat / (sehat + tidakSehat + 1);
      karbo = 1 - protein - lemak;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(theme),
                  const SizedBox(height: 24),
                  _buildPieChart(theme),
                  const SizedBox(height: 24),
                  _buildNutritionProgress(theme),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(ThemeData theme) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.orange),
                const SizedBox(width: 8),
                Text('Pantau Gizi Siswa',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Text('Jumlah input makanan yang terekam: $totalInput',
                style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart(ThemeData theme) {
    if (sehatCount + tidakSehatCount == 0) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.bar_chart, color: Colors.teal),
                  const SizedBox(width: 8),
                  Text('Persentase Gizi Siswa',
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text('Belum ada data gizi siswa.', style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.bar_chart, color: Colors.teal),
                const SizedBox(width: 8),
                Text('Persentase Gizi Siswa',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 160,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                      sections: [
                        if (sehatCount > 0)
                          PieChartSectionData(
                            value: sehatCount.toDouble(),
                            color: Colors.green,
                            title: '$sehatCount Sehat',
                            radius: 50,
                            titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        if (tidakSehatCount > 0)
                          PieChartSectionData(
                            value: tidakSehatCount.toDouble(),
                            color: Colors.red,
                            title: '$tidakSehatCount Tidak',
                            radius: 50,
                            titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.health_and_safety, color: Colors.grey),
                      Text(
                        '${((sehatCount / (sehatCount + tidakSehatCount)) * 100).toStringAsFixed(0)}% Sehat',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionProgress(ThemeData theme) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.local_dining, color: Colors.brown),
                const SizedBox(width: 8),
                Text('Nutrisi Paling Dibutuhkan',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            _nutrisiRow(theme, 'Protein 🍖', protein, Colors.green),
            _nutrisiRow(theme, 'Lemak 🧁', lemak, Colors.amber),
            _nutrisiRow(theme, 'Karbohidrat 🍚', karbo, Colors.lightBlue),
          ],
        ),
      ),
    );
  }

  Widget _nutrisiRow(ThemeData theme, String label, double value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label, style: theme.textTheme.bodyMedium)),
          Expanded(
            child: LinearProgressIndicator(
              value: value,
              color: color,
              backgroundColor: color.withOpacity(0.2),
              minHeight: 10,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 12),
          Text('${(value * 100).toInt()}%', style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}