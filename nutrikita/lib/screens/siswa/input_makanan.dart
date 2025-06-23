import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class InputMakananScreen extends StatefulWidget {
  const InputMakananScreen({super.key});

  @override
  State<InputMakananScreen> createState() => _InputMakananScreenState();
}

class _InputMakananScreenState extends State<InputMakananScreen> {
  String? _selectedMealTime;
  String? _selectedUnit;
  String? _selectedFoodSource;
  Uint8List? _imageBytes;
  double? kalori;

  final TextEditingController makananController = TextEditingController();
  final TextEditingController porsiController = TextEditingController();
  final TextEditingController catatanController = TextEditingController();

  final List<String> _mealTimes = [
    'Sarapan', 'Makan Siang', 'Makan Malam',
    'Camilan Pagi', 'Camilan Sore', 'Lainnya',
  ];

  final List<String> _units = [
    'gram', 'ml', 'porsi', 'buah', 'sendok', 'cup', 'lainnya',
  ];

  final List<String> _foodSources = [
    'Homemade', 'Restoran', 'Supermarket', 'Kantin', 'Lainnya',
  ];

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _imageBytes = result.files.single.bytes;
      });
    }
  }

  Future<void> _hitungKalori() async {
    final namaMakanan = makananController.text.trim();
    if (namaMakanan.isEmpty) return;

    try {
      final response = await http.post(
        Uri.parse('https://trackapi.nutritionix.com/v2/natural/nutrients'),
        headers: {
          'Content-Type': 'application/json',
          'x-app-id': '9122dd4c',
          'x-app-key': '767d25a287df998aa5da6767df97ad2f',
        },
        body: jsonEncode({'query': namaMakanan}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final firstFood = data['foods'][0];
        setState(() {
          kalori = firstFood['nf_calories']?.toDouble();
        });
      } else {
        throw Exception('Gagal ambil data kalori');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal hitung kalori: $e')),
      );
    }
  }

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
      final base64Image = _imageBytes != null ? base64Encode(_imageBytes!) : null;

      await FirebaseFirestore.instance.collection('input_makanan').add({
        'uid': user?.uid,
        'email': user?.email,
        'waktu_makan': _selectedMealTime,
        'nama_makanan': makananController.text,
        'porsi': porsiController.text,
        'satuan': _selectedUnit,
        'sumber': _selectedFoodSource,
        'catatan': catatanController.text,
        'foto_base64': base64Image,
        'kalori': kalori ?? 0,
        'created_at': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data makanan berhasil diinput!')),
      );

      makananController.clear();
      porsiController.clear();
      catatanController.clear();
      setState(() {
        _selectedMealTime = null;
        _selectedUnit = null;
        _selectedFoodSource = null;
        _imageBytes = null;
        kalori = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan data: $e')),
      );
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
      appBar: AppBar(
        title: const Text('Input Makanan'),
        backgroundColor: Colors.teal[300],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDropdown('Waktu Makan', 'Pilih waktu makan', _selectedMealTime, _mealTimes, (val) => setState(() => _selectedMealTime = val)),
              const SizedBox(height: 16),

              _buildTextField('Nama Makanan / Minuman', 'Contoh: Nasi Goreng Ayam', 1, makananController),
              const SizedBox(height: 12),

              Text('Upload Foto Makanan', style: theme.textTheme.labelLarge),
              const SizedBox(height: 8),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.upload),
                    label: const Text('Pilih Gambar'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal[300]),
                  ),
                  const SizedBox(width: 12),
                  if (_imageBytes != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(_imageBytes!, width: 100, height: 100, fit: BoxFit.cover),
                    )
                ],
              ),
              const SizedBox(height: 16),

              Text('Ukuran Porsi', style: theme.textTheme.labelLarge),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: porsiController,
                      decoration: const InputDecoration(hintText: 'Banyak', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedUnit,
                      items: _units.map((unit) => DropdownMenuItem(value: unit, child: Text(unit))).toList(),
                      onChanged: (val) => setState(() => _selectedUnit = val),
                      decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Satuan'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              _buildDropdown('Sumber Makanan', 'Pilih sumber makanan', _selectedFoodSource, _foodSources, (val) => setState(() => _selectedFoodSource = val)),
              const SizedBox(height: 16),

              _buildTextField('Catatan Tambahan', 'Misal: tidak pakai sambal', 3, catatanController),
              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: _hitungKalori,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange[300]),
                child: const Text('Hitung Kalori', style: TextStyle(color: Colors.white)),
              ),
              if (kalori != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text('Estimasi Kalori: ${kalori!.toStringAsFixed(2)} kkal', style: theme.textTheme.bodyMedium),
                ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _simpanData,
                  icon: const Icon(Icons.save),
                  label: const Text('Simpan Data'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String hint, String? value, List<String> items, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(hintText: hint, border: const OutlineInputBorder()),
          value: value,
          items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildTextField(String label, String hint, int maxLines, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(hintText: hint, border: const OutlineInputBorder()),
        ),
      ],
    );
  }
}
