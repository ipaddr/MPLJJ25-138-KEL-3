// lib/screens/dashboard_screen.dart

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

import '../siswa/articles.dart';
import '../siswa/input_makanan.dart';
import '../profile.dart';
import '../../widget/bottom_nav_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  DateTime currentWeekStartDate = _getFirstDayOfWeek(DateTime.now());

  static DateTime _getFirstDayOfWeek(DateTime date) =>
      date.subtract(Duration(days: date.weekday - 1));

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
              toolbarHeight: 100,
              backgroundColor: theme.colorScheme.primary,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
              ),
              automaticallyImplyLeading: false,
              title: Row(children: [
                CircleAvatar(
                  backgroundColor: theme.colorScheme.onPrimary,
                  radius: 24,
                  child: Icon(Icons.home, color: theme.colorScheme.primary),
                ),
                const SizedBox(width: 16),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Dashboard',
                      style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onPrimary)),
                  Row(children: [
                    Text('Status Gizi: ',
                        style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimary)),
                    const Icon(Icons.circle, color: Colors.green, size: 12),
                    const SizedBox(width: 4),
                    Text('Baik',
                        style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimary)),
                  ]),
                ]),
              ]),
              actions: [
                IconButton(
                  icon: Icon(Icons.notifications, color: theme.colorScheme.onPrimary),
                  onPressed: () {},
                )
              ],
            )
          : null,
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _DashboardContent(currentWeekStartDate: currentWeekStartDate),
          const InputMakananScreen(),
          const ArticlesScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Articles'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class _DashboardContent extends StatefulWidget {
  final DateTime currentWeekStartDate;
  const _DashboardContent({required this.currentWeekStartDate});

  @override
  State<_DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<_DashboardContent> {
  late DateTime weekStart;
  late DateTime weekEnd;
  bool isLoading = true;
  List<double> karbo = List.filled(7, 0);
  List<double> protein = List.filled(7, 0);
  List<double> lemak = List.filled(7, 0);
  List<Map<String, dynamic>> rekomendasi = [];

  @override
  void initState() {
    super.initState();
    weekStart = widget.currentWeekStartDate;
    weekEnd = weekStart.add(const Duration(days: 6));
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return;

      final snapshot = await FirebaseFirestore.instance
          .collection('input_makanan')
          .where('uid', isEqualTo: uid)
          .where('created_at', isGreaterThanOrEqualTo: weekStart)
          .where('created_at', isLessThanOrEqualTo: weekEnd.add(const Duration(days: 1)))
          .get();

      List<double> k = List.filled(7, 0);
      List<double> p = List.filled(7, 0);
      List<double> l = List.filled(7, 0);

      for (var doc in snapshot.docs) {
        final createdAt = (doc['created_at'] as Timestamp?)?.toDate();
        if (createdAt == null) continue;

        int index = createdAt.weekday - 1;
        print("Input pada hari ${createdAt.weekday}, index ke-$index: ${createdAt.toIso8601String()}");

        k[index] += double.tryParse(doc['karbohidrat']?.toString() ?? '0') ?? 0;
        p[index] += double.tryParse(doc['protein']?.toString() ?? '0') ?? 0;
        l[index] += double.tryParse(doc['lemak']?.toString() ?? '0') ?? 0;
      }

      print('Karbo per hari: $k');
      print('Protein per hari: $p');
      print('Lemak per hari: $l');

      final rekomSnapshot = await FirebaseFirestore.instance.collection('rekomendasi_makanan').get();

      final allRekom = rekomSnapshot.docs.map((doc) => {
        'judul': doc['judul']?.toString() ?? '',
        'deskripsi': doc['deskripsi']?.toString() ?? '',
      }).toList();

      allRekom.shuffle();

      setState(() {
        karbo = k;
        protein = p;
        lemak = l;
        rekomendasi = allRekom.take(3).toList();
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching data: $e");
      setState(() => isLoading = false);
    }
  }

  void _refreshRekomendasi() async {
    final snapshot = await FirebaseFirestore.instance.collection('rekomendasi_makanan').get();
    final allRekom = snapshot.docs.map((doc) => {
      'judul': doc['judul']?.toString() ?? '',
      'deskripsi': doc['deskripsi']?.toString() ?? '',
    }).toList();

    allRekom.shuffle();

    setState(() {
      rekomendasi = allRekom.take(3).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (isLoading) return const Center(child: CircularProgressIndicator());

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Konsumsi Gizi', style: theme.textTheme.titleLarge),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () => setState(() {
                      weekStart = weekStart.subtract(const Duration(days: 7));
                      weekEnd = weekStart.add(const Duration(days: 6));
                      isLoading = true;
                      _fetchData();
                    }),
                icon: const Icon(Icons.arrow_left)),
            Text('${DateFormat('d MMM').format(weekStart)} - ${DateFormat('d MMM').format(weekEnd)}'),
            IconButton(
                onPressed: () => setState(() {
                      weekStart = weekStart.add(const Duration(days: 7));
                      weekEnd = weekStart.add(const Duration(days: 6));
                      isLoading = true;
                      _fetchData();
                    }),
                icon: const Icon(Icons.arrow_right)),
          ],
        ),
        const SizedBox(height: 12),
        AspectRatio(
          aspectRatio: 1.2, // Disesuaikan agar batang grafik lebih tinggi
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barGroups: List.generate(7, (index) {
                return BarChartGroupData(x: index, barRods: [
                  BarChartRodData(
                    toY: karbo[index] + protein[index] + lemak[index],
                    rodStackItems: [
                      BarChartRodStackItem(0, karbo[index], Colors.green.shade200),
                      BarChartRodStackItem(karbo[index], karbo[index] + protein[index], Colors.blue.shade200),
                      BarChartRodStackItem(karbo[index] + protein[index], karbo[index] + protein[index] + lemak[index], Colors.red.shade200),
                    ],
                    borderRadius: BorderRadius.circular(6),
                  )
                ]);
              }),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, _) => Text('${value.toInt()}'),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, _) {
                      final days = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
                      return Text(days[value.toInt()]);
                    },
                  ),
                ),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(show: true),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildLegend('Karbohidrat', Colors.green.shade200),
            _buildLegend('Protein', Colors.blue.shade200),
            _buildLegend('Lemak', Colors.red.shade200),
          ],
        ),
        const SizedBox(height: 24),
        Text('Rekomendasi Makanan', style: theme.textTheme.titleLarge),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: _refreshRekomendasi,
          icon: const Icon(Icons.refresh),
          label: const Text("Refresh Rekomendasi"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: rekomendasi.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (_, i) {
            return ListTile(
              tileColor: Colors.grey.shade100,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              leading: const Icon(Icons.food_bank, color: Colors.teal),
              title: Text(rekomendasi[i]['judul']),
              subtitle: Text(rekomendasi[i]['deskripsi']),
            );
          },
        ),
      ]),
    );
  }

  Widget _buildLegend(String label, Color color) {
    return Row(
      children: [
        Container(width: 12, height: 12, color: color),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}
