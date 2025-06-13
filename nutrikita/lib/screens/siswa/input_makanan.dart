import 'package:flutter/material.dart';

class InputMakananScreen extends StatefulWidget {
  const InputMakananScreen({super.key});

  @override
  State<InputMakananScreen> createState() => _InputMakananScreenState();
}

class _InputMakananScreenState extends State<InputMakananScreen> {
  String? _selectedMealTime;
  String? _selectedUnit;
  String? _selectedFoodSource;

  final List<String> _mealTimes = [
    'Sarapan',
    'Makan Siang',
    'Makan Malam',
    'Camilan Pagi',
    'Camilan Sore',
    'Lainnya',
  ];
  final List<String> _units = [
    'gram',
    'ml',
    'porsi',
    'buah',
    'sendok',
    'cup',
    'lainnya',
  ];
  final List<String> _foodSources = [
    'Homemade',
    'Restoran',
    'Supermarket',
    'Kantin',
    'Lainnya',
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

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
                titlePadding: const EdgeInsets.only(left: 24.0, bottom: 16.0),
                title: Text(
                  'Input Makanan',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.onBackground,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Waktu Makan
                            Text('Waktu', style: theme.textTheme.labelLarge),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                hintText: 'Pilih waktu makan',
                              ),
                              value: _selectedMealTime,
                              items:
                                  _mealTimes.map((String time) {
                                    return DropdownMenuItem<String>(
                                      value: time,
                                      child: Text(time),
                                    );
                                  }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedMealTime = newValue;
                                });
                              },
                            ),
                            const SizedBox(height: 16),

                            // Makanan / Minuman & Kuantitas
                            Text(
                              'Makanan / Minuman',
                              style: theme.textTheme.labelLarge,
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              maxLines: 3,
                              decoration: const InputDecoration(
                                hintText:
                                    'Masukkan makanan / minuman yang dikonsumsi',
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Ukuran Porsi
                            Text(
                              'Ukuran Porsi',
                              style: theme.textTheme.labelLarge,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: 'Banyak',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  flex: 2,
                                  child: DropdownButtonFormField<String>(
                                    decoration: const InputDecoration(
                                      hintText: 'Satuan',
                                    ),
                                    value: _selectedUnit,
                                    items:
                                        _units.map((String unit) {
                                          return DropdownMenuItem<String>(
                                            value: unit,
                                            child: Text(unit),
                                          );
                                        }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedUnit = newValue;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Sumber Makanan
                            Text(
                              'Sumber Makanan',
                              style: theme.textTheme.labelLarge,
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                hintText: 'Pilih sumber makanan',
                              ),
                              value: _selectedFoodSource,
                              items:
                                  _foodSources.map((String source) {
                                    return DropdownMenuItem<String>(
                                      value: source,
                                      child: Text(source),
                                    );
                                  }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedFoodSource = newValue;
                                });
                              },
                            ),
                            const SizedBox(height: 16),

                            // Foto Makanan
                            Text(
                              'Foto Makanan',
                              style: theme.textTheme.labelLarge,
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surface,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: theme.dividerColor),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.upload_file,
                                    size: 40,
                                    color: theme.iconTheme.color,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Tambahkan foto makanan',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Catatan
                            Text('Catatan', style: theme.textTheme.labelLarge),
                            const SizedBox(height: 8),
                            TextFormField(
                              maxLines: 3,
                              decoration: const InputDecoration(
                                hintText: 'Masukkan keterangan tambahan',
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Tombol Simpan
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Data makanan berhasil diinput! (Dummy)',
                                      ),
                                    ),
                                  );
                                  Navigator.pop(context);
                                },
                                child: const Text('Simpan'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
