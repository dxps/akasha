import 'package:akasha_ui/theming/colors.dart';
import 'package:flutter/material.dart';

ThemeData initThemeData(Brightness brightness) {
  final isDark = brightness == Brightness.dark;

  final colorScheme = ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: brightness,
  );

  final base = ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: isDark ? primaryDarkBgColor : Colors.grey.shade200,
  );

  return base.copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: isDark ? primaryDarkBgColor : Colors.grey.shade200,
      foregroundColor: isDark ? primaryDarkFgColor : Colors.black87,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
    ),

    dataTableTheme: DataTableThemeData(
      headingTextStyle: TextStyle(
        color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
        fontSize: 13,
      ),
      dataTextStyle: TextStyle(
        color: isDark ? Colors.grey.shade100 : Colors.black87,
        fontSize: 14,
      ),
      dataRowMinHeight: 30,
      dataRowMaxHeight: 30,
      dividerThickness: 0.25,
      headingRowHeight: 30,
    ),

    dialogTheme: DialogThemeData(
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: isDark ? Colors.white : Colors.black87,
      ),
      contentTextStyle: TextStyle(
        fontSize: 14,
        color: isDark ? Colors.white70 : Colors.black87,
      ),
    ),

    dividerColor: isDark ? Colors.grey.shade700 : Colors.grey.shade300,

    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: TextStyle(
        fontSize: 14,
        color: isDark ? Colors.grey.shade100 : Colors.black87,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.disabled)) {
            return isDark ? Colors.grey.shade800 : Colors.grey.shade300;
          }
          if (states.contains(WidgetState.hovered)) {
            return isDark ? const Color(0xFF243126) : const Color.fromARGB(255, 224, 251, 224);
          }
          return isDark ? const Color(0xFF2A2D2E) : Colors.white;
        }),
        foregroundColor: WidgetStatePropertyAll(
          isDark ? Colors.grey.shade100 : Colors.black87,
        ),
        elevation: WidgetStateProperty.resolveWith<double?>((states) {
          if (states.contains(WidgetState.disabled)) return 0;
          return 1;
        }),
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
    ),

    iconTheme: IconThemeData(
      color: isDark ? Colors.grey.shade100 : Colors.black87,
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: const UnderlineInputBorder(),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: isDark ? Colors.grey.shade600 : Colors.grey.shade500,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: isDark ? colorScheme.primary : colorScheme.primary,
        ),
      ),
      filled: false,
      hoverColor: Colors.transparent,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      labelStyle: TextStyle(
        fontSize: 14,
        color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
      ),
      floatingLabelStyle: TextStyle(
        fontSize: 15,
        color: colorScheme.primary,
      ),
      hintStyle: TextStyle(
        fontSize: 13,
        color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
      ),
      helperStyle: TextStyle(
        fontSize: 12,
        color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
      ),
      errorStyle: const TextStyle(fontSize: 12),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
    ),

    listTileTheme: ListTileThemeData(
      titleTextStyle: TextStyle(
        fontSize: 14,
        color: isDark ? Colors.grey.shade100 : Colors.black87,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: isDark ? Colors.grey.shade100 : Colors.black87,
        side: BorderSide(
          color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: isDark ? const Color(0xFF2A2D2E) : Colors.white,
        foregroundColor: isDark ? Colors.grey.shade100 : Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    textTheme: base.textTheme.copyWith(
      bodyLarge: TextStyle(
        fontSize: 15,
        color: isDark ? Colors.grey.shade100 : Colors.black87,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: isDark ? Colors.grey.shade100 : Colors.black87,
      ),
      titleMedium: TextStyle(
        fontSize: 14,
        color: isDark ? Colors.grey.shade100 : Colors.black87,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        color: isDark ? Colors.grey.shade100 : Colors.black87,
      ),
      labelMedium: TextStyle(
        fontSize: 14,
        color: isDark ? Colors.grey.shade100 : Colors.black87,
      ),
    ),
  );
}
