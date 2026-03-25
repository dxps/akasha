import 'package:flutter/material.dart';

class DateTimePickers {
  //
  static Future<DateTime?> pickDate(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    BorderRadius? borderRadius,
    Color backgroundColor = Colors.white,
    Color headerBackgroundColor = Colors.white,
    Color cancelButtonBackgroundColor = const Color(0xFFE0E0E0),
    Color confirmButtonBackgroundColor = const Color(0xFFD1C4E9),
  }) async {
    final radius = borderRadius ?? BorderRadius.circular(10);
    final now = DateTime.now();

    return showDatePicker(
      context: context,
      initialDate: initialDate ?? now,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
      builder: (context, child) {
        final theme = Theme.of(context);

        return Theme(
          data: theme.copyWith(
            datePickerTheme: DatePickerThemeData(
              shape: RoundedRectangleBorder(borderRadius: radius),
              backgroundColor: backgroundColor,
              headerBackgroundColor: headerBackgroundColor,
              surfaceTintColor: Colors.transparent,
              cancelButtonStyle: TextButton.styleFrom(
                backgroundColor: cancelButtonBackgroundColor,
                shape: RoundedRectangleBorder(borderRadius: radius),
              ),
              confirmButtonStyle: TextButton.styleFrom(
                backgroundColor: confirmButtonBackgroundColor,
                shape: RoundedRectangleBorder(borderRadius: radius),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }

  static Future<DateTime?> pickDateTime(
    BuildContext context, {
    DateTime? initialDateTime,
    DateTime? firstDate,
    DateTime? lastDate,
    BorderRadius? borderRadius,
  }) async {
    final now = initialDateTime ?? DateTime.now();

    final date = await pickDate(
      context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
      borderRadius: borderRadius,
    );

    if (date == null) return null;
    if (!context.mounted) return null;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(now),
    );

    if (time == null) return null;

    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }
}
