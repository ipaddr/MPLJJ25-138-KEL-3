import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widget/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/profile.dart';

class SekolahScreen extends StatefulWidget {
  const SekolahScreen({super.key});

  @override
  State<SekolahScreen> createState() => _SekolahScreenState();
}

class _SekolahScreenState extends State<SekolahScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    _SekolahDashboardContent(),
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
      appBar:
          _selectedIndex == 0
              ? AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: theme.scaffoldBackgroundColor,
                elevation: 0,

                title: Text(
                  'Dashboard Sekolah',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.onBackground,
                  ),
                ),
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

// Widget untuk konten dashboard sekolah
class _SekolahDashboardContent extends StatelessWidget {
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
                  Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selamat Datang, Admin SD Negeri 1 Sana!',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Pantau perkembangan gizi dan kesehatan siswa di sekolah Anda.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _infoBox(
                                theme,
                                icon: Icons.people,
                                label: 'Siswa',
                                value: '1.200',
                                color: theme.colorScheme.primary,
                              ),
                              _infoBox(
                                theme,
                                icon: Icons.restaurant_menu,
                                label: 'Menu',
                                value: '15',
                                color: Colors.orange,
                              ),
                              _infoBox(
                                theme,
                                icon: Icons.health_and_safety,
                                label: 'Sehat',
                                value: '85%',
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Persentase Gizi Siswa',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 120,
                            child: PieChart(
                              PieChartData(
                                sectionsSpace: 2,
                                centerSpaceRadius: 30,
                                sections: [
                                  PieChartSectionData(
                                    value: 70,
                                    color: Colors.green,
                                    title: '70%',
                                    radius: 40,
                                    titleStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: 25,
                                    color: Colors.orange,
                                    title: '25%',
                                    radius: 40,
                                    titleStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: 5,
                                    color: Colors.red,
                                    title: '5%',
                                    radius: 40,
                                    titleStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nutrisi Paling Dibutuhkan',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _nutrisiRow(theme, 'Protein', 0.9, Colors.green),
                          _nutrisiRow(theme, 'Lemak', 0.7, Colors.amber),
                          _nutrisiRow(
                            theme,
                            'Karbohidrat',
                            0.5,
                            Colors.lightGreenAccent,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoBox(
    ThemeData theme, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: theme.textTheme.bodySmall),
      ],
    );
  }

  Widget _nutrisiRow(ThemeData theme, String label, double value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: theme.textTheme.bodyMedium),
          ),
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
