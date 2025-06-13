import 'package:flutter/material.dart';

class InputDataSiswaScreen extends StatelessWidget {
  const InputDataSiswaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF7), // putih hint cream
      appBar: AppBar(
        backgroundColor: const Color(0xFFA8D5BA),
        title: const Text(
          'Perbarui Data Fisik',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Masukan Tinggi Anak"),
              const SizedBox(height: 4),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Masukan tinggi dalam cm",
                  helperText: "Tinggi badan diukur dalam centimeter",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              const Text("Masukan Berat Anak"),
              const SizedBox(height: 4),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Masukan berat dalam kg",
                  helperText: "Berat badan diukur dalam kilogram",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              const Text("Tanggal"),
              const SizedBox(height: 4),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "DD/MM/YYYY",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              const Text("Catatan"),
              const SizedBox(height: 4),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Masukan kondisi tubuh hari ini",
                  helperText: "Misal: Hari ini baru sembuh dari flu",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.from(alpha: 1, red: 0.863, green: 0.733, blue: 0.302),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    
                  },
                  child: const Text("Simpan"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
