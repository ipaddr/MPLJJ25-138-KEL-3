import 'package:flutter/material.dart';
import 'package:nutrikita/utils/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.primaryGreen,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryGreen,
      brightness: Brightness.light,
      primary: AppColors.primaryGreen,
      onPrimary: AppColors.white,
      secondary: AppColors.primaryBlue,
      onSecondary: AppColors.white,
      tertiary: AppColors.secondaryYellow,
      onTertiary: AppColors.darkText,
      surface: AppColors.lightGreyBackground,
      onSurface: AppColors.darkText,
      background: AppColors.lightGreyBackground,
      onBackground: AppColors.darkText,
      error: AppColors.accentRedWarning,
      onError: AppColors.white,
    ),
    scaffoldBackgroundColor: AppColors.lightGreyBackground,
    cardColor: AppColors.white,
    iconTheme: const IconThemeData(color: AppColors.primaryGreen, size: 24),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryGreen,
      foregroundColor: AppColors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.white),
      titleTextStyle: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondaryOrange,
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        shadowColor: AppColors.secondaryOrange.withAlpha((0.4 * 255).toInt()),
        elevation: 4,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.primaryGreen, width: 1.5),
        foregroundColor: AppColors.primaryGreen,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryGreen,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: AppColors.greyText.withAlpha((0.7 * 255).toInt()),
      ),
      fillColor: AppColors.white,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.mediumLightGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.mediumLightGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.accentRedWarning,
          width: 2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.accentRedWarning,
          width: 2,
        ),
      ),
      labelStyle: const TextStyle(color: AppColors.darkText),
    ),
    cardTheme: CardTheme(
      color: AppColors.white,
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      shadowColor: AppColors.mediumLightGrey,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryGreen,
      foregroundColor: AppColors.white,
      elevation: 4,
      shape: CircleBorder(),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.mediumLightGrey,
      thickness: 1,
      space: 1,
    ),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      iconColor: AppColors.primaryGreen,
      textColor: AppColors.darkText,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.lightGreyBackground,
      disabledColor: AppColors.mediumLightGrey,
      selectedColor: AppColors.primaryGreen.withAlpha((0.2 * 255).toInt()),
      secondarySelectedColor: AppColors.primaryBlue.withAlpha(
        (0.2 * 255).toInt(),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      labelStyle: const TextStyle(
        color: AppColors.darkText,
        fontWeight: FontWeight.w500,
      ),
      secondaryLabelStyle: const TextStyle(
        color: AppColors.primaryBlue,
        fontWeight: FontWeight.w500,
      ),
      brightness: Brightness.light,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    // --- TEXT THEME ---
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 57.0,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
        color: AppColors.darkText,
        height: 1.1,
      ),
      displayMedium: TextStyle(
        fontSize: 45.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
        color: AppColors.darkText,
        height: 1.2,
      ),
      displaySmall: TextStyle(
        fontSize: 36.0,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.0,
        color: AppColors.darkText,
        height: 1.25,
      ),
      headlineLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.0,
        color: AppColors.darkText,
        height: 1.25,
      ),
      headlineMedium: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
        color: AppColors.darkText,
        height: 1.3,
      ),
      headlineSmall: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
        color: AppColors.darkText,
        height: 1.33,
      ),
      titleLarge: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
        color: AppColors.darkText,
        height: 1.27,
      ),
      titleMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: AppColors.darkText,
        height: 1.5,
      ),
      titleSmall: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: AppColors.darkText,
        height: 1.43,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: AppColors.darkText,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: AppColors.darkText,
        height: 1.43,
      ),
      bodySmall: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: AppColors.greyText,
        height: 1.33,
      ),
      labelLarge: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
        color: AppColors.darkText,
        height: 1.43,
      ),
      labelMedium: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: AppColors.darkText,
        height: 1.33,
      ),
      labelSmall: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: AppColors.darkText,
        height: 1.45,
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    splashColor: AppColors.primaryGreen.withAlpha((0.08 * 255).toInt()),
    highlightColor: AppColors.primaryGreen.withAlpha((0.04 * 255).toInt()),
    focusColor: AppColors.primaryBlue.withAlpha((0.12 * 255).toInt()),
    hoverColor: AppColors.primaryGreen.withAlpha((0.04 * 255).toInt()),
    // Standar shape
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titleTextStyle: const TextStyle(
        color: AppColors.darkText,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      contentTextStyle: const TextStyle(
        color: AppColors.darkText,
        fontSize: 16,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(color: AppColors.darkText, fontSize: 14),
    ),
    // Standar padding
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
