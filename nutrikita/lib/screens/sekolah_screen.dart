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
  int totalSiswa = 0;
  double rataKalori = 0;
  double rataProtein = 0;
  double rataKarbo = 0;
  double rataLemak = 0;
  double persentaseGiziBaik = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final snapshot = await FirebaseFirestore.instance.collection('input_makanan').get();
    final data = snapshot.docs;

    Map<String, List<Map<String, dynamic>>> siswaMakanan = {};

    for (var doc in data) {
      final uid = doc['uid'] ?? '';
      if (!siswaMakanan.containsKey(uid)) {
        siswaMakanan[uid] = [];
      }
      siswaMakanan[uid]!.add(doc.data());
    }

    int total = siswaMakanan.length;
    double totalKalori = 0;
    double totalProtein = 0;
    double totalKarbo = 0;
    double totalLemak = 0;
    int totalGiziBaik = 0;

    for (var makanan in siswaMakanan.values) {
      double kal = 0, pro = 0, kar = 0, lem = 0;
      for (var item in makanan) {
        kal += (item['kalori'] ?? 0).toDouble();
        pro += (item['protein'] ?? 0).toDouble();
        kar += (item['karbohidrat'] ?? 0).toDouble();
        lem += (item['lemak'] ?? 0).toDouble();
      }
      totalKalori += kal / makanan.length;
      totalProtein += pro / makanan.length;
      totalKarbo += kar / makanan.length;
      totalLemak += lem / makanan.length;
      if ((kal / makanan.length) >= 1500) totalGiziBaik++;
    }

    setState(() {
      totalSiswa = total;
      rataKalori = total == 0 ? 0 : totalKalori / total;
      rataProtein = total == 0 ? 0 : totalProtein / total;
      rataKarbo = total == 0 ? 0 : totalKarbo / total;
      rataLemak = total == 0 ? 0 : totalLemak / total;
      persentaseGiziBaik = total == 0 ? 0 : totalGiziBaik / total;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(theme),
            const SizedBox(height: 24),
            _buildStatusGiziCard(theme, persentaseGiziBaik),
            const SizedBox(height: 24),
            _buildBarChart(theme),
            const SizedBox(height: 100),
          ],
        ),
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
                const Icon(Icons.people, color: Colors.teal),
                const SizedBox(width: 8),
                Text('Data Gizi Siswa', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Text('Total siswa input: $totalSiswa', style: theme.textTheme.bodyMedium),
            Text('Rata-rata Kalori: ${rataKalori.toStringAsFixed(2)} kkal', style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusGiziCard(ThemeData theme, double persentase) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(Icons.health_and_safety, color: Colors.green),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status Gizi Baik', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('${(persentase * 100).toStringAsFixed(0)}% siswa dalam status gizi baik', style: theme.textTheme.bodyMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart(ThemeData theme) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.bar_chart, color: Colors.orange),
                const SizedBox(width: 8),
                Text('Rata-rata Nutrisi per Siswa', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNutrisiBar('Protein', rataProtein, Colors.blue),
                _buildNutrisiBar('Karbo', rataKarbo, Colors.purple),
                _buildNutrisiBar('Lemak', rataLemak, Colors.redAccent),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrisiBar(String label, double value, Color color) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 100,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: FractionallySizedBox(
            heightFactor: value / 100,
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 30,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label),
        Text('${value.toStringAsFixed(1)} g'),
      ],
    );
  }
}