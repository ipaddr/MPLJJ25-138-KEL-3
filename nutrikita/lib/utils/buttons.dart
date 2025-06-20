import 'package:flutter/material.dart';
import 'package:nutrikita/utils/app_colors.dart';

class SmallButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;

  const SmallButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.backgroundColor = AppColors.darkText,
    this.foregroundColor = AppColors.lightGreyBackground,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 24),
      label: Text(label, style: const TextStyle(fontSize: 14)),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: const Size(200, 40),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
