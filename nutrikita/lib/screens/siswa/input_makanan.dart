import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:nutrikita/utils/food_nutrition.dart'; // Pastikan path ini benar

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
  // kalori ini tidak digunakan, bisa dihapus atau diganti dengan userNutrient.calories
  // double? kalori;
  FoodNutrient? foodNutrient; // Base nutrition from API per serving
  FoodNutrient? userNutrient; // Calculated nutrition based on user's input
  String? unitWarning;

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

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _imageBytes = result.files.single.bytes;
      });
    }
  }

  Future<void> _hitungNutrisi() async {
    final namaMakanan = makananController.text.trim();
    final porsiText = porsiController.text.trim();
    final satuan = _selectedUnit;

    if (namaMakanan.isEmpty || porsiText.isEmpty || satuan == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama Makanan, Porsi, dan Satuan wajib diisi.'),
        ),
      );
      return;
    }

    double? jumlah;
    try {
      jumlah = double.parse(porsiText);
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jumlah porsi harus berupa angka.')),
      );
      return;
    }

    // Reset previous nutrition data and warning
    setState(() {
      foodNutrient = null;
      userNutrient = null;
      unitWarning = null;
    });

    try {
      // Periksa apakah nama makanan memerlukan terjemahan ke Inggris
      // Asumsi 'translateToEnglish' ada di food_nutrition.dart
      final translatedName = await translateToEnglish(namaMakanan);
      // Jika Nutritionix API hanya menerima bahasa Inggris, pastikan terjemahan ini efektif
      // Jika nama makanan seperti "Nasi Goreng" sudah dikenal Nutritionix, terjemahan mungkin tidak perlu.
      // Anda bisa menambahkan logika pengecekan bahasa di sini jika diperlukan.

      final response = await http.post(
        Uri.parse('https://trackapi.nutritionix.com/v2/natural/nutrients'),
        headers: {
          'Content-Type': 'application/json',
          'x-app-id': '9122dd4c',
          'x-app-key': '767d25a287df998aa5da6767df97ad2f',
        },
        body: jsonEncode({'query': translatedName}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['foods'] != null && data['foods'].isNotEmpty) {
          final firstFood = data['foods'][0];
          final baseNutrient = FoodNutrient.fromJson(firstFood);

          double beratInput = convertToGram(jumlah, satuan);
          String? warning;

          // Jika satuan tidak ada di map konversi, berikan warning
          if (!unitToGram.containsKey(satuan)) {
            warning =
                'Satuan "$satuan" tidak bisa dikonversi otomatis. Hasil mungkin tidak akurat. Masukkan berat dalam gram untuk hasil akurat.';
          } else if (satuan == 'lainnya' && (jumlah == 0 || beratInput == 0)) {
            // Jika "lainnya" dan jumlahnya 0, ingatkan untuk input gram yang valid
            warning =
                'Untuk satuan "lainnya", pastikan Anda memasukkan berat dalam gram yang valid.';
          }

          setState(() {
            foodNutrient = baseNutrient;
            userNutrient = calculateNutrientByWeight(baseNutrient, beratInput);
            unitWarning = warning;
          });
        } else {
          throw Exception('Data nutrisi tidak ditemukan untuk makanan ini.');
        }
      } else {
        // Coba baca error message dari API jika ada
        String errorMessage =
            'Gagal ambil data nutrisi. Status Code: ${response.statusCode}';
        try {
          final errorData = jsonDecode(response.body);
          if (errorData['message'] != null) {
            errorMessage = errorData['message'];
          }
        } catch (_) {
          // Do nothing, use default message
        }
        throw Exception(errorMessage);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal hitung nutrisi: $e')));
    }
  }

  Future<void> _simpanData() async {
    if (_selectedMealTime == null ||
        makananController.text.isEmpty ||
        porsiController.text.isEmpty ||
        _selectedUnit == null ||
        _selectedFoodSource == null ||
        userNutrient ==
            null // Pastikan nutrisi sudah dihitung
            ) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Mohon lengkapi semua data dan hitung nutrisi terlebih dahulu.',
          ),
        ),
      );
      return;
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Anda harus login untuk menyimpan data.'),
          ),
        );
        return;
      }

      final base64Image =
          _imageBytes != null ? base64Encode(_imageBytes!) : null;

      await FirebaseFirestore.instance.collection('input_makanan').add({
        'uid': user.uid, // Gunakan user.uid langsung
        'email': user.email,
        'waktu_makan': _selectedMealTime,
        'nama_makanan': makananController.text,
        'porsi': porsiController.text,
        'satuan': _selectedUnit,
        'sumber': _selectedFoodSource,
        'catatan': catatanController.text,
        'foto_base64': base64Image,
        'kalori': userNutrient!.calories, // Pastikan tidak null
        'karbohidrat': userNutrient!.carbs,
        'protein': userNutrient!.protein,
        'lemak': userNutrient!.fat,
        'created_at': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data makanan berhasil diinput!')),
      );

      // Clear all fields and state after successful save
      makananController.clear();
      porsiController.clear();
      catatanController.clear();
      setState(() {
        _selectedMealTime = null;
        _selectedUnit = null;
        _selectedFoodSource = null;
        _imageBytes = null;
        // kalori = null; // Ini tidak lagi digunakan
        foodNutrient = null;
        userNutrient = null;
        unitWarning = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
              _buildDropdown(
                'Waktu Makan',
                'Pilih waktu makan',
                _selectedMealTime,
                _mealTimes,
                (val) => setState(() => _selectedMealTime = val),
              ),
              const SizedBox(height: 16),

              _buildTextField(
                'Nama Makanan / Minuman',
                'Contoh: Nasi Goreng Ayam',
                1,
                makananController,
              ),
              const SizedBox(height: 12),

              Text('Upload Foto Makanan', style: theme.textTheme.labelLarge),
              const SizedBox(height: 8),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.upload),
                    label: const Text('Pilih Gambar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[300],
                      foregroundColor:
                          Colors.white, // Ensure text color is visible
                    ),
                  ),
                  const SizedBox(width: 12),
                  if (_imageBytes != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        _imageBytes!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
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
                      decoration: const InputDecoration(
                        hintText: 'Banyak',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<String>(
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
                      onChanged: (val) => setState(() => _selectedUnit = val),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Satuan',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              _buildDropdown(
                'Sumber Makanan',
                'Pilih sumber makanan',
                _selectedFoodSource,
                _foodSources,
                (val) => setState(() => _selectedFoodSource = val),
              ),
              const SizedBox(height: 16),

              _buildTextField(
                'Catatan Tambahan',
                'Misal: tidak pakai sambal',
                3,
                catatanController,
              ),
              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: _hitungNutrisi,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[300],
                  foregroundColor: Colors.white, // Ensure text color is visible
                ),
                child: const Text('Hitung Nutrisi'),
              ),
              if (userNutrient != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Estimasi Nutrisi untuk ${userNutrient!.servingWeightGrams.toStringAsFixed(2)} gram:',
                        style: theme.textTheme.bodyMedium,
                      ),
                      Text(
                        'Kalori: \t${userNutrient!.calories.toStringAsFixed(2)} kkal',
                      ),
                      Text(
                        'Karbohidrat: ${userNutrient!.carbs.toStringAsFixed(2)} g',
                      ),
                      Text(
                        'Lemak: \t${userNutrient!.fat.toStringAsFixed(2)} g',
                      ),
                      Text(
                        'Protein: \t${userNutrient!.protein.toStringAsFixed(2)} g',
                      ),
                      if (unitWarning != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            unitWarning!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  ),
                ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _simpanData,
                  icon: const Icon(Icons.save, color: Colors.white),
                  label: const Text(
                    'Simpan Data',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    String hint,
    String? value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge,
        ), // Added text style
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

  Widget _buildTextField(
    String label,
    String hint,
    int maxLines,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge,
        ), // Added text style
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
