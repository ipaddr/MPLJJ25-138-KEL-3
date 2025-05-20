import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SekolahScreen extends StatelessWidget {
  const SekolahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5F1FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(  // <- Tambahan ini
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                const Row(
                  children: [
                    CircleAvatar(radius: 24, backgroundColor: Colors.grey),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, User!',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Pantau nutrisi anak dan tetap sehat',
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Donut chart
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Persentase gizi siswa',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 150,
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 2,
                            centerSpaceRadius: 40,
                            sections: [
                              PieChartSectionData(
                                value: 70,
                                color: Colors.green,
                                title: '70%',
                                radius: 50,
                                titleStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              PieChartSectionData(
                                value: 25,
                                color: Colors.orange,
                                title: '25%',
                                radius: 50,
                                titleStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              PieChartSectionData(
                                value: 5,
                                color: Colors.red,
                                title: '5%',
                                radius: 50,
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
                const SizedBox(height: 24),

                // Line chart perkembangan
                const Text(
                  'Perkembangan kondisi siswa',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true,
                          spots: const [
                            FlSpot(0, 1),
                            FlSpot(1, 1.1),
                            FlSpot(2, 1.05),
                            FlSpot(3, 1.15),
                            FlSpot(4, 1.2),
                            FlSpot(5, 1.18),
                            FlSpot(6, 1.22),
                            FlSpot(7, 1.2),
                            FlSpot(8, 1.23),
                            FlSpot(9, 1.25),
                            FlSpot(10, 1.27),
                            FlSpot(11, 1.3),
                          ],
                          color: Colors.black, 
                          barWidth: 2,
                        ),
                      ],
                      titlesData: FlTitlesData(show: false),
                      gridData: FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Bar chart nutrisi
                const Text(
                  'Nutrisi yang paling dibutuhkan siswa',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildNutrisiBar('Protein', 0.9, Colors.green),
                      _buildNutrisiBar('Lemak', 0.7, Colors.yellow),
                      _buildNutrisiBar('Karbohidrat', 0.5, Colors.lightGreenAccent),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNutrisiBar(String label, double value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text(label)),
          Expanded(
            child: Container(
              height: 14,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
              width: 200 * value,
            ),
          ),
        ],
      ),
    );
  }
}
