// File: utils/app_colors.dart (Ini tidak berubah)

import 'package:flutter/material.dart';

class AppColors {
  // 1. Warna Primer (Dominan)
  static const Color primaryGreen = Color(
    0xFFA5D6A7,
  ); // Hijau Muda (Light Green)
  static const Color primaryBlue = Color(0xFF90CAF9); // Biru Langit (Sky Blue)

  // 2. Warna Sekunder (Pendukung)
  static const Color secondaryYellow = Color(
    0xFFFFF176,
  ); // Kuning Terang (Warm Yellow)
  static const Color secondaryOrange = Color(
    0xFFFFCC80,
  ); // Oranye Lembut (Soft Orange)

  // 3. Warna Aksen (Penarik Perhatian & Data Visualisasi)
  static const Color accentRedWarning = Color(
    0xFFEF9A9A,
  ); // Merah Kecil (Subtle Red) untuk peringatan
  static const Color accentDeepPurple = Color(
    0xFF7B1FA2,
  ); // Ungu Tua (Deep Purple) untuk elemen penting/grafik

  // 4. Warna Netral (untuk Teks dan Background)
  static const Color darkText = Color(
    0xFF424242,
  ); // Abu-abu Tua (Dark Grey) untuk teks utama
  static const Color greyText = Color(
    0xFF616161,
  ); // Abu-abu Sedang (opsional, bisa digunakan untuk sub-teks)
  static const Color lightGreyBackground = Color(
    0xFFF5F5F5,
  ); // Abu-abu Muda (Light Grey) untuk latar belakang utama scaffold
  static const Color mediumLightGrey = Color(
    0xFFEEEEEE,
  ); // Abu-abu yang sedikit lebih gelap dari lightGreyBackground, untuk border/divider
  static const Color white = Color(
    0xFFFFFFFF,
  ); // Putih untuk latar belakang card/konten

  // Warna Semantik (berdasarkan penggunaan)
  static const Color successGreen = Color(
    0xFF4CAF50,
  ); // Contoh hijau untuk sukses/optimal
  static const Color infoBlue = Color(
    0xFF2196F3,
  ); // Contoh biru untuk info/indikator
}
