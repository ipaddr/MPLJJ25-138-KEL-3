import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InputMakananScreen extends StatefulWidget {
  const InputMakananScreen({super.key});

  @override
  State<InputMakananScreen> createState() => _InputMakananScreenState();
}

class _InputMakananScreenState extends State<InputMakananScreen> {
  String? _selectedMealTime;
  String? _selectedUnit;
  String? _selectedFoodSource;

  final TextEditingController makananController = TextEditingController();
  final TextEditingController porsiController = TextEditingController();
  final TextEditingController catatanController = TextEditingController();

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

  Future<void> _simpanData() async {
    if (_selectedMealTime == null ||
        makananController.text.isEmpty ||
        porsiController.text.isEmpty ||
        _selectedUnit == null ||
        _selectedFoodSource == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mohon lengkapi semua data')),
      );
      return;
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection('input_makanan').add({
        'uid': user?.uid,
        'waktu_makan': _selectedMealTime,
        'nama_makanan': makananController.text,
        'porsi': porsiController.text,
        'satuan': _selectedUnit,
        'sumber': _selectedFoodSource,
        'catatan': catatanController.text,
        'created_at': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data makanan berhasil diinput!')),
      );
      // Reset field
      makananController.clear();
      porsiController.clear();
      catatanController.clear();
      setState(() {
        _selectedMealTime = null;
        _selectedUnit = null;
        _selectedFoodSource = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menyimpan data: $e')));
    }
  }

  @override
  void dispose() {
    makananController.dispose();
    porsiController.dispose();
    catatanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF7),
      appBar: AppBar(
        title: const Text(
          'Input Makanan',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFA8D5BA),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDropdown(
                        label: 'Waktu Makan',
                        hint: 'Pilih waktu makan',
                        value: _selectedMealTime,
                        items: _mealTimes,
                        onChanged:
                            (val) => setState(() => _selectedMealTime = val),
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: 'Makanan / Minuman',
                        hint: 'Masukkan makanan / minuman yang dikonsumsi',
                        maxLines: 3,
                        controller: makananController,
                      ),
                      const SizedBox(height: 16),
                      Text('Ukuran Porsi', style: theme.textTheme.labelLarge),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              controller: porsiController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Banyak',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 2,
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                hintText: 'Satuan',
                                border: OutlineInputBorder(),
                              ),
                              value: _selectedUnit,
                              items:
                                  _units
                                      .map(
                                        (unit) => DropdownMenuItem(
                                          value: unit,
                                          child: Text(unit),
                                        ),
                                      )
                                      .toList(),
                              onChanged:
                                  (val) => setState(() => _selectedUnit = val),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildDropdown(
                        label: 'Sumber Makanan',
                        hint: 'Pilih sumber makanan',
                        value: _selectedFoodSource,
                        items: _foodSources,
                        onChanged:
                            (val) => setState(() => _selectedFoodSource = val),
                      ),
                      const SizedBox(height: 16),
                      Text('Foto Makanan', style: theme.textTheme.labelLarge),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          // TODO: Tambah logika unggah foto
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade100,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_photo_alternate_outlined,
                                color: Colors.grey.shade600,
                                size: 40,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Tambahkan foto makanan',
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: 'Catatan',
                        hint: 'Masukkan keterangan tambahan',
                        maxLines: 3,
                        controller: catatanController,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFDD9D4B),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _simpanData,
                          child: const Text(
                            'Simpan',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
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
    );
  }

  Widget _buildDropdown({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
          ),
          value: value,
          items:
              items
                  .map(
                    (item) => DropdownMenuItem(value: item, child: Text(item)),
                  )
                  .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    int maxLines = 1,
    TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
