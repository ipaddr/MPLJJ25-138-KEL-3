import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../siswa/articles.dart';
import '../../utils/app_colors.dart';
import '../../utils/nutrition_chart.dart';
import '../siswa/input_makanan.dart';
import '../profile.dart';
import '../../widget/bottom_nav_bar.dart'; // pastikan path ini benar

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  DateTime currentWeekStartDate = _getFirstDayOfWeek(DateTime.now());

  final List<Widget> _widgetOptions = <Widget>[
    _DashboardContent(),
    const InputMakananScreen(),
    const ArticlesScreen(),
    const ProfileScreen(),
  ];

  static DateTime _getFirstDayOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  void _goToPreviousWeek() {
    setState(() {
      currentWeekStartDate = currentWeekStartDate.subtract(
        const Duration(days: 7),
      );
    });
  }

  void _goToNextWeek() {
    setState(() {
      currentWeekStartDate = currentWeekStartDate.add(const Duration(days: 7));
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar:
          _selectedIndex == 0
              ? AppBar(
                toolbarHeight: 100,
                backgroundColor: theme.colorScheme.primary,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(24),
                  ),
                ),
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: theme.colorScheme.onPrimary,
                      radius: 24,
                      child: Icon(Icons.home, color: theme.colorScheme.primary),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rafii Ahmad Fahreza',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Status Gizi: ',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                            const Icon(
                              Icons.circle,
                              color: AppColors.successGreen,
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Baik',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.notifications,
                      color: theme.colorScheme.onPrimary,
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 24),
                ],
              )
              : null,
      body: IndexedStack(index: _selectedIndex, children: _widgetOptions),
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

// --- Ekstrak Konten Dashboard ke Widget Terpisah ---
// Ini dilakukan agar konten dashboard bisa menjadi salah satu child di IndexedStack
class _DashboardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _DashboardScreenState? parentState =
        context.findAncestorStateOfType<_DashboardScreenState>();

    final currentWeekEndDate = parentState!.currentWeekStartDate.add(
      const Duration(days: 6),
    );

    final formattedStartDate = DateFormat(
      'dd MMM',
    ).format(parentState.currentWeekStartDate);
    final formattedEndDate = DateFormat('dd MMM').format(currentWeekEndDate);

    final List<Map<String, double>> dummyDailyNutritionData = [
      {'carbs': 220, 'protein': 35, 'fat': 50},
      {'carbs': 220, 'protein': 40, 'fat': 52},
      {'carbs': 225, 'protein': 68, 'fat': 78},
      {'carbs': 235, 'protein': 72, 'fat': 65},
      {'carbs': 228, 'protein': 86, 'fat': 69},
      {'carbs': 232, 'protein': 69, 'fat': 81},
      {'carbs': 227, 'protein': 54, 'fat': 97},
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian ini sekarang tanpa AppBar karena AppBar ditangani di DashboardScreen
            Text('Konsumsi Gizi', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 8),
            Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              color: theme.colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: parentState._goToPreviousWeek,
                        ),
                        Text(
                          '$formattedStartDate - $formattedEndDate',
                          style: theme.textTheme.titleMedium,
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios),
                          onPressed: parentState._goToNextWeek,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: CustomPaint(
                        painter: NutritionChartPainter(
                          carbsColor: AppColors.primaryGreen,
                          proteinColor: AppColors.primaryBlue,
                          fatColor: AppColors.accentRedWarning,
                          dailyNutritionData: dummyDailyNutritionData,
                          theme: theme,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildLegendItem(AppColors.primaryGreen, 'Karbohidrat'),
                        _buildLegendItem(AppColors.primaryBlue, 'Protein'),
                        _buildLegendItem(AppColors.accentRedWarning, 'Lemak'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Rekomendasi Makanan', style: theme.textTheme.headlineSmall),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Pilihan Sehat Untuk Kamu',
                style: theme.textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  color: theme.colorScheme.surface,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.colorScheme.onSurface.withAlpha(
                              25,
                            ), // 0.1 * 255 = 25.5
                          ),
                          child: Center(
                            child: Icon(
                              Icons.water,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Susu', style: theme.textTheme.titleMedium),
                              Text(
                                'Penting untuk pertumbuhan tulang dan gigi yang kuat.',
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  color: theme.colorScheme.surface,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.colorScheme.onSurface.withAlpha(25),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.local_florist,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sayur Hijau',
                                style: theme.textTheme.titleMedium,
                              ),
                              Text(
                                'Cocok untuk kamu yang perlu serat lebih',
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              color: theme.colorScheme.surface,
              child: Container(
                height: 180,
                width: double.infinity,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Foto Makanan Harian',
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.circle,
                          size: 8,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.circle_outlined,
                          size: 8,
                          color: theme.colorScheme.onSurface.withAlpha(
                            128,
                          ), // 0.5 * 255 = 127.5
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.circle_outlined,
                          size: 8,
                          color: theme.colorScheme.onSurface.withAlpha(128),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Tantangan Gizi', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    color: theme.colorScheme.surface,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hari ini', style: theme.textTheme.titleMedium),
                          const SizedBox(height: 8),
                          Text(
                            '+70 Poin',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    color: theme.colorScheme.surface,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Minggu ini',
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '+230 Poin',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(width: 12, height: 12, color: color),
        const SizedBox(width: 4),
        Text(text),
      ],
    );
  }
}
