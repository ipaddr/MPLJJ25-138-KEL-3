import 'package:flutter/material.dart';

class InputDataSiswaScreen extends StatelessWidget {
  const InputDataSiswaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFA8D5BA),
        elevation: 0,
        title: const Text(
          'Perbarui Data Fisik',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInputSection(
                label: "Tinggi Anak",
                hint: "Masukan tinggi dalam cm",
                helper: "Tinggi badan diukur dalam centimeter",
              ),
              const SizedBox(height: 16),
              _buildInputSection(
                label: "Berat Anak",
                hint: "Masukan berat dalam kg",
                helper: "Berat badan diukur dalam kilogram",
              ),
              const SizedBox(height: 16),
              _buildInputSection(
                label: "Tanggal",
                hint: "DD/MM/YYYY",
              ),
              const SizedBox(height: 16),
              _buildInputSection(
                label: "Catatan",
                hint: "Masukan kondisi tubuh hari ini",
                helper: "Misal: Hari ini baru sembuh dari flu",
                maxLines: 3,
              ),
              const SizedBox(height: 32),
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
                  onPressed: () {
                    // TODO: Implementasi penyimpanan
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Data Tersimpan"),
                        content: const Text(
                            "Data fisik anak berhasil diperbarui."),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("OK"),
                          )
                        ],
                      ),
                    );
                  },
                  child: const Text(
                    "Simpan",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputSection({
    required String label,
    required String hint,
    String? helper,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            helperText: helper,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
          ),
        ),
      ],
    );
  }
}
