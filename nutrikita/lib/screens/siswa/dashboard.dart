import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  void _goToPreviousWeek() =>
      setState(() => currentWeekStartDate = currentWeekStartDate.subtract(const Duration(days: 7)));

  void _goToNextWeek() =>
      setState(() => currentWeekStartDate = currentWeekStartDate.add(const Duration(days: 7)));

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
                  Text('Dashboard', style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onPrimary)),
                  Row(children: [
                    Text('Status Gizi: ', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimary)),
                    const Icon(Icons.circle, color: Colors.green, size: 12),
                    const SizedBox(width: 4),
                    Text('Baik', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimary)),
                  ]),
                ]),
              ]),
              actions: [IconButton(icon: Icon(Icons.notifications, color: theme.colorScheme.onPrimary), onPressed: () {})],
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
  List<double> carbs = List.filled(7, 0);
  List<String> fotoHarian = [];

  @override
  void initState() {
    super.initState();
    weekStart = widget.currentWeekStartDate;
    weekEnd = widget.currentWeekStartDate.add(const Duration(days: 6));
    _fetchWeeklyData();
  }

  Future<void> _fetchWeeklyData() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return;

      final snapshot = await FirebaseFirestore.instance
          .collection('input_makanan')
          .where('uid', isEqualTo: uid)
          .where('created_at', isGreaterThanOrEqualTo: weekStart)
          .where('created_at', isLessThanOrEqualTo: weekEnd.add(const Duration(days: 1)))
          .get();

      List<double> dailyTotals = List.filled(7, 0);
      List<String> imageList = [];

      for (var doc in snapshot.docs) {
        final createdAt = (doc['created_at'] as Timestamp?)?.toDate();
        if (createdAt == null) continue;

        final weekdayIndex = createdAt.weekday - 1;
        final kalori = double.tryParse(doc['kalori']?.toString() ?? '0') ?? 0;
        dailyTotals[weekdayIndex] += kalori;

        final foto = doc['foto_base64'];
        if (foto != null && foto is String && foto.isNotEmpty) {
          imageList.add(foto);
        }
      }

      setState(() {
        carbs = dailyTotals;
        fotoHarian = imageList;
        isLoading = false;
      });
    } catch (e) {
      print('Fetch error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double rataKalori = carbs.fold(0.0, (a, b) => a + b) / 7;

    if (isLoading) return const Center(child: CircularProgressIndicator());

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Rangkuman Mingguan', style: theme.textTheme.headlineSmall),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Foto Makanan', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  fotoHarian.isNotEmpty
                      ? SizedBox(
                          height: 120,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: fotoHarian.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 12),
                            itemBuilder: (_, i) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.memory(
                                  base64Decode(fotoHarian[i]),
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        )
                      : Text('Belum ada foto', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.local_fire_department, color: Colors.deepOrange, size: 40),
                    const SizedBox(height: 8),
                    Text('${rataKalori.toStringAsFixed(1)} kkal', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    const Text('Rata-rata kalori per hari'),
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 24),
        Text('Grafik Kalori Harian', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12),
        Column(
          children: List.generate(7, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  SizedBox(width: 60, child: Text(DateFormat.E().format(weekStart.add(Duration(days: index))))),
                  const SizedBox(width: 8),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: (carbs[index] / 3000).clamp(0.0, 1.0),
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                      minHeight: 14,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('${carbs[index].toStringAsFixed(0)} kkal'),
                ],
              ),
            );
          }),
        )
      ]),
    );
  }
}
