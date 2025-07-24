import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widget/bottom_nav_bar.dart';
import '../screens/profile.dart';
import 'input_artikel_screen.dart';

class PemerintahScreen extends StatefulWidget {
  const PemerintahScreen({super.key});

  @override
  State<PemerintahScreen> createState() => _PemerintahScreenState();
}

class _PemerintahScreenState extends State<PemerintahScreen> {
  int _selectedIndex = 0;
  int jumlahAnak = 0;
  int jumlahSekolah = 0;
  int jumlahFeedback = 0;
  int jumlahGiziBurukMingguIni = 0;
  int jumlahSekolahBelumInput = 0;

  Map<String, int> statusGizi = {'Baik': 0, 'Kurang': 0, 'Buruk': 0};

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final users = await FirebaseFirestore.instance.collection('users').get();
    final siswa = users.docs.where((doc) => doc['role'] == 'siswa');
    final sekolah = users.docs.where((doc) => doc['role'] == 'sekolah');

    final feedbacks = await FirebaseFirestore.instance.collection('feedback_ortu').get();
    final inputMakanan = await FirebaseFirestore.instance.collection('input_makanan').get();

    Map<String, int> gizi = {'Baik': 0, 'Kurang': 0, 'Buruk': 0};

    DateTime now = DateTime.now();
    DateTime sevenDaysAgo = now.subtract(const Duration(days: 7));

    int giziBurukMingguIni = 0;
    Set<String> sekolahAktif = {};
    Set<String> semuaSekolah = {};

    for (var item in inputMakanan.docs) {
      final data = item.data();
      final timestamp = (data['created_at'] as Timestamp?)?.toDate();
      final kalori = (data['kalori'] ?? 0).toDouble();
      final sekolah = data['sekolah'] ?? '';

      if (kalori >= 500) {
        gizi['Baik'] = gizi['Baik']! + 1;
      } else if (kalori >= 300) {
        gizi['Kurang'] = gizi['Kurang']! + 1;
      } else {
        gizi['Buruk'] = gizi['Buruk']! + 1;
      }

      if (timestamp != null && timestamp.isAfter(sevenDaysAgo)) {
        if (kalori < 300) giziBurukMingguIni++;
        if (sekolah.isNotEmpty) sekolahAktif.add(sekolah);
      }
      if (sekolah.isNotEmpty) semuaSekolah.add(sekolah);
    }

    int sekolahBelumInput = semuaSekolah.length - sekolahAktif.length;

    setState(() {
      jumlahAnak = siswa.length;
      jumlahSekolah = sekolah.length;
      jumlahFeedback = feedbacks.size;
      statusGizi = gizi;
      jumlahGiziBurukMingguIni = giziBurukMingguIni;
      jumlahSekolahBelumInput = sekolahBelumInput;
    });
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<Widget> _widgetOptions = [
      _PemerintahDashboardContent(
        jumlahAnak: jumlahAnak,
        jumlahSekolah: jumlahSekolah,
        jumlahFeedback: jumlahFeedback,
        statusGizi: statusGizi,
        jumlahGiziBurukMingguIni: jumlahGiziBurukMingguIni,
        jumlahSekolahBelumInput: jumlahSekolahBelumInput,
      ),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: _selectedIndex == 0
          ? AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: theme.colorScheme.surface,
              elevation: 1,
              actions: [
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  tooltip: 'Input Artikel',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const InputArtikelScreen()),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Keluar',
                  onPressed: () => showDialog(
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
                          onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                          child: const Text('Keluar'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              title: const Text('Dashboard Pemerintah', style: TextStyle(color: Colors.black)),
            )
          : null,
      body: IndexedStack(index: _selectedIndex, children: _widgetOptions),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class _PemerintahDashboardContent extends StatelessWidget {
  final int jumlahAnak;
  final int jumlahSekolah;
  final int jumlahFeedback;
  final Map<String, int> statusGizi;
  final int jumlahGiziBurukMingguIni;
  final int jumlahSekolahBelumInput;

  const _PemerintahDashboardContent({
    required this.jumlahAnak,
    required this.jumlahSekolah,
    required this.jumlahFeedback,
    required this.statusGizi,
    required this.jumlahGiziBurukMingguIni,
    required this.jumlahSekolahBelumInput,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Program Gizi Nasional', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildInfoCard(theme, 'assets/icons/siswa.png', '$jumlahAnak', 'Jumlah Anak', theme.primaryColor)),
                const SizedBox(width: 16),
                Expanded(child: _buildInfoCard(theme, 'assets/icons/sekolah.png', '$jumlahSekolah', 'Jumlah Sekolah', Colors.orange)),
              ],
            ),
            const SizedBox(height: 16),
            Center(child: _buildInfoCard(theme, 'assets/icons/laporan.png', '$jumlahFeedback', 'Laporan Masuk', Colors.green)),
            const SizedBox(height: 32),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Image.asset('assets/icons/status.png', height: 28),
                      const SizedBox(width: 8),
                      Text('Status Gizi Nasional', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    ]),
                    const Divider(height: 24),
                    _giziStatusItem(theme, '🟢 Baik', '${statusGizi['Baik']}'),
                    _giziStatusItem(theme, '🟠 Kurang', '${statusGizi['Kurang']}'),
                    _giziStatusItem(theme, '🔴 Buruk', '${statusGizi['Buruk']}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Image.asset('assets/icons/peringatan.png', height: 24),
                      const SizedBox(width: 8),
                      Text('Notifikasi Penting', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.error)),
                    ]),
                    const Divider(height: 24),
                    Text('⚠️ Siswa dengan gizi buruk minggu ini: $jumlahGiziBurukMingguIni', style: theme.textTheme.bodyMedium),
                    Text('📌 Sekolah yang belum kirim data >3 hari: $jumlahSekolahBelumInput sekolah', style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(ThemeData theme, String iconPath, String value, String label, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Column(
          children: [
            Image.asset(iconPath, height: 36),
            const SizedBox(height: 12),
            Text(value, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: color, fontSize: 20)),
            const SizedBox(height: 4),
            Text(label, style: theme.textTheme.bodyMedium, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _giziStatusItem(ThemeData theme, String kategori, String jumlah) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(kategori, style: theme.textTheme.bodyLarge),
          Text(jumlah, style: theme.textTheme.bodyLarge),
        ],
      ),
    );
  }
}
