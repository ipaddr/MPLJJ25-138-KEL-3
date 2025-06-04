// File: screens/add_consumption_screen.dart

import 'package:flutter/material.dart';

class InputMakanan extends StatefulWidget {
  const InputMakanan({super.key});

  @override
  State<InputMakanan> createState() => _InputMakananState();
}

class _InputMakananState extends State<InputMakanan> {
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
  final List<String> _units = ['gram', 'ml', 'porsi', 'buah', 'lainnya'];
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
      appBar: AppBar(title: const Text('Tambah Konsumsi')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Waktu Makan
                      Text('Waktu Makan', style: theme.textTheme.labelLarge),
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
                      const SizedBox(height: 20),

                      // Makanan / Minuman & Kuantitas
                      Text(
                        'Makanan / Minuman',
                        style: theme.textTheme.labelLarge,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Nama makanan/minuman',
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Banyak',
                                  style: theme.textTheme.labelLarge,
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    hintText: 'Jumlah',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Satuan',
                                  style: theme.textTheme.labelLarge,
                                ),
                                const SizedBox(height: 8),
                                DropdownButtonFormField<String>(
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
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Sumber Makanan
                      Text('Sumber Makanan', style: theme.textTheme.labelLarge),
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
                      const SizedBox(height: 20),

                      // Foto Makanan
                      Text('Foto Makanan', style: theme.textTheme.labelLarge),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        decoration: BoxDecoration(
                          color:
                              theme
                                  .colorScheme
                                  .surface, // Menggunakan warna surface dari tema
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: theme.dividerTheme.color!,
                          ), // Menggunakan warna divider dari tema
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              size: 40,
                              color:
                                  theme
                                      .iconTheme
                                      .color, // Menggunakan warna icon dari tema
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Tambahkan foto makanan',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color:
                                    theme
                                        .colorScheme
                                        .onSurfaceVariant, // Warna teks netral
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Catatan
                      Text('Catatan', style: theme.textTheme.labelLarge),
                      const SizedBox(height: 8),
                      TextFormField(
                        maxLines: 3,
                        decoration: const InputDecoration(
                          hintText: 'Masukkan keterangan tambahan',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Tombol Simpan
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implementasi logika simpan data konsumsi
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Data konsumsi berhasil disimpan! (Dummy)',
                        ),
                      ),
                    );
                    Navigator.pop(
                      context,
                    ); // Kembali ke halaman sebelumnya setelah simpan
                  },
                  child: const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
