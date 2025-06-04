import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class NutritionChartPainter extends CustomPainter {
  final Color carbsColor;
  final Color proteinColor;
  final Color fatColor;
  final List<Map<String, double>> dailyNutritionData;
  final ThemeData theme;

  NutritionChartPainter({
    required this.carbsColor,
    required this.proteinColor,
    required this.fatColor,
    required this.dailyNutritionData,
    required this.theme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint carbsPaint = Paint()..color = carbsColor;
    final Paint proteinPaint = Paint()..color = proteinColor;
    final Paint fatPaint = Paint()..color = fatColor;
    final Paint gridPaint =
        Paint()
          ..color = theme.colorScheme.outlineVariant.withOpacity(0.5)
          ..strokeWidth = 1;

    final TextStyle axisLabelStyle = theme.textTheme.bodySmall!.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
      fontSize: 10,
    );

    const int numberOfBars = 7;
    const double leftPadding = 30.0;
    const double bottomPadding = 20.0;

    final double chartWidth = size.width - leftPadding;
    final double chartHeight = size.height - bottomPadding;

    final double barWidth = (chartWidth / numberOfBars) * 0.6;
    final double spacing = (chartWidth / numberOfBars) * 0.4;
    // final double borderRadius = barWidth / 4; // Baris ini tidak lagi digunakan

    const double maxNutritionValue = 500.0; // Sesuaikan nilai maksimal gizi

    // ============ Gambar Garis Bantu Horizontal dan Label Angka Y-axis ============
    const int numHorizontalLines = 5;
    for (int i = 0; i <= numHorizontalLines; i++) {
      final double yValue = (maxNutritionValue / numHorizontalLines) * i;
      final double yPos =
          chartHeight - (yValue / maxNutritionValue) * chartHeight;

      canvas.drawLine(
        Offset(leftPadding, yPos),
        Offset(size.width, yPos),
        gridPaint,
      );

      final TextPainter textPainter = TextPainter(
        text: TextSpan(text: yValue.toInt().toString(), style: axisLabelStyle),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          leftPadding - textPainter.width - 5,
          yPos - textPainter.height / 2,
        ),
      );
    }

    // ============ Gambar Bar Gizi ============
    for (int i = 0; i < dailyNutritionData.length; i++) {
      final double x = leftPadding + (i * (barWidth + spacing)) + (spacing / 2);
      final Map<String, double> dayData = dailyNutritionData[i];

      final double carbs = dayData['carbs'] ?? 0;
      final double protein = dayData['protein'] ?? 0;
      final double fat = dayData['fat'] ?? 0;

      final double scaleFactor = chartHeight / maxNutritionValue;

      final double carbsHeight = carbs * scaleFactor;
      final double proteinHeight = protein * scaleFactor;
      final double fatHeight = fat * scaleFactor;

      double currentY =
          chartHeight; // Mulai dari bawah area chart yang tersedia

      // Gambar Karbohidrat (paling bawah di bar)
      final double carbsRectTop = currentY - carbsHeight;
      canvas.drawRect(
        Rect.fromLTWH(x, carbsRectTop, barWidth, carbsHeight),
        carbsPaint,
      );
      currentY -= carbsHeight;

      // Gambar Protein
      final double proteinRectTop = currentY - proteinHeight;
      canvas.drawRect(
        Rect.fromLTWH(x, proteinRectTop, barWidth, proteinHeight),
        proteinPaint,
      );
      currentY -= proteinHeight;

      // Gambar Lemak (paling atas di bar)
      final double fatRectTop = currentY - fatHeight;
      final RRect fatRRect = RRect.fromRectAndCorners(
        Rect.fromLTWH(x, fatRectTop, barWidth, fatHeight),
        topLeft: Radius.circular(barWidth / 4),
        topRight: Radius.circular(barWidth / 4),
      );
      canvas.drawRRect(fatRRect, fatPaint);
    }
  }

  @override
  bool shouldRepaint(covariant NutritionChartPainter oldDelegate) {
    return oldDelegate.dailyNutritionData != dailyNutritionData ||
        oldDelegate.carbsColor != carbsColor ||
        oldDelegate.proteinColor != proteinColor ||
        oldDelegate.fatColor != fatColor ||
        oldDelegate.theme != theme;
  }
}
