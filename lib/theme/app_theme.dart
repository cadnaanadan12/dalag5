import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Midabada guud ee application-ka Dalag.
class AppColors {
  AppColors._();

  // ---- Light theme ----
  static const Color primaryGreen = Color(0xFF4C6B12);
  static const Color darkGreen = Color(0xFF3A5210);
  static const Color lightGreenChip = Color(0xFFE7E8C9);
  static const Color background = Color(0xFFF4F3EC);
  static const Color cardBackground = Colors.white;
  static const Color beige = Color(0xFFE6E1BB);
  static const Color textDark = Color(0xFF2B2B22);
  static const Color textGrey = Color(0xFF7A7A6C);
  static const Color positive = Color(0xFF3E8E2F);
  static const Color negative = Color(0xFFC94B4B);
  static const Color danger = Color(0xFFC0392B);

  // ---- Dark theme (professional, warm-neutral, not pure black) ----
  static const Color darkBackground = Color(0xFF12140F);
  static const Color darkCard = Color(0xFF1C1F16);
  static const Color darkSurfaceElevated = Color(0xFF242819);
  static const Color darkChip = Color(0xFF2A2E1E);
  static const Color darkBorder = Color(0xFF32361F);
  static const Color darkText = Color(0xFFF2F3EC);
  static const Color darkGrey = Color(0xFFA7AC98);
  static const Color darkAccent =
      Color(0xFF8BC34A); // brighter, legible on dark
  static const Color darkPositive = Color(0xFF6FCF6F);
  static const Color darkNegative = Color(0xFFE57373);
}

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);
    final textTheme = GoogleFonts.poppinsTextTheme(base.textTheme);

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.primaryGreen,
        secondary: AppColors.beige,
        error: AppColors.danger,
      ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.poppins(
          color: AppColors.primaryGreen,
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
        iconTheme: const IconThemeData(color: AppColors.textDark),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(56),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          textStyle:
              GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
          elevation: 2,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryGreen,
          minimumSize: const Size.fromHeight(56),
          side: const BorderSide(color: AppColors.primaryGreen, width: 1.4),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          textStyle:
              GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFDDDCC8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFDDDCC8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:
              const BorderSide(color: AppColors.primaryGreen, width: 1.6),
        ),
        hintStyle: const TextStyle(color: AppColors.textGrey),
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardBackground,
        elevation: 1.5,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        margin: EdgeInsets.zero,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.primaryGreen
              : Colors.white,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.primaryGreen.withOpacity(0.5)
              : Colors.black12,
        ),
      ),
    );
  }

  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);
    final textTheme = GoogleFonts.poppinsTextTheme(base.textTheme).apply(
      bodyColor: AppColors.darkText,
      displayColor: AppColors.darkText,
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.darkAccent,
        secondary: AppColors.darkChip,
        surface: AppColors.darkCard,
        error: AppColors.darkNegative,
        onPrimary: Colors.black,
        onSurface: AppColors.darkText,
      ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.poppins(
          color: AppColors.darkAccent,
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
        iconTheme: const IconThemeData(color: AppColors.darkText),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkAccent,
          foregroundColor: Colors.black,
          minimumSize: const Size.fromHeight(56),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          textStyle:
              GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.darkAccent,
          minimumSize: const Size.fromHeight(56),
          side: const BorderSide(color: AppColors.darkAccent, width: 1.4),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          textStyle:
              GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.darkAccent),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkCard,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.darkAccent, width: 1.6),
        ),
        hintStyle: const TextStyle(color: AppColors.darkGrey),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkCard,
        elevation: 0,
        shadowColor: Colors.black54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: AppColors.darkBorder, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkCard,
        selectedItemColor: AppColors.darkAccent,
        unselectedItemColor: AppColors.darkGrey,
        elevation: 0,
      ),
      listTileTheme: const ListTileThemeData(
        tileColor: Colors.transparent,
        textColor: AppColors.darkText,
        iconColor: AppColors.darkAccent,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.darkBorder,
        thickness: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.darkSurfaceElevated,
        contentTextStyle: const TextStyle(color: AppColors.darkText),
        actionTextColor: AppColors.darkAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.darkCard,
        titleTextStyle: const TextStyle(
          color: AppColors.darkText,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        contentTextStyle: const TextStyle(color: AppColors.darkGrey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.darkCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: AppColors.darkChip,
        selectedColor: AppColors.darkAccent,
        labelStyle: const TextStyle(
            color: AppColors.darkText, fontWeight: FontWeight.w600),
        secondaryLabelStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        side: const BorderSide(color: AppColors.darkBorder),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.darkAccent
              : AppColors.darkGrey,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.darkAccent.withOpacity(0.45)
              : AppColors.darkBorder,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.darkAccent
              : Colors.transparent,
        ),
        checkColor: const WidgetStatePropertyAll(Colors.black),
        side: const BorderSide(color: AppColors.darkGrey),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.darkAccent
              : AppColors.darkGrey,
        ),
      ),
      iconTheme: const IconThemeData(color: AppColors.darkText),
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: const WidgetStatePropertyAll(AppColors.darkCard),
          surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
      ),
      popupMenuTheme: const PopupMenuThemeData(
        color: AppColors.darkCard,
        textStyle: TextStyle(color: AppColors.darkText),
      ),
    );
  }
}
