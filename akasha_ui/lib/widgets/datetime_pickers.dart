import 'package:akasha_ui/theming/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateTimePickers {
  //
  static Future<DateTime?> pickDate(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    BorderRadius? borderRadius,
    Color? backgroundColor,
    Color? headerBackgroundColor,
    Color? cancelButtonBackgroundColor,
    Color? confirmButtonBackgroundColor,
  }) async {
    final radius = borderRadius ?? BorderRadius.circular(10);
    final now = DateTime.now();
    final isDarkMode = context.read<ThemeCubit>().isDarkMode;

    backgroundColor = backgroundColor ?? (isDarkMode ? Colors.grey.shade800 : Colors.white);
    cancelButtonBackgroundColor = cancelButtonBackgroundColor ?? (isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300);
    confirmButtonBackgroundColor = confirmButtonBackgroundColor ?? (isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300);
    headerBackgroundColor = headerBackgroundColor ?? (isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300);

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
    final isDarkMode = context.read<ThemeCubit>().isDarkMode;

    final date = await pickDate(
      context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
      borderRadius: borderRadius,
    );

    if (date == null) return null;
    if (!context.mounted) return null;

    final backgroundColor = isDarkMode ? Colors.grey.shade800 : Colors.white;
    final cancelButtonBackgroundColor = isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300;
    final confirmButtonBackgroundColor = isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300;
    final radius = borderRadius ?? BorderRadius.circular(10);

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(now),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(borderRadius: radius),
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
