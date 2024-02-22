import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:ditoast/utils/prefs.dart';
import 'package:ditoast/utils/ricochlime_palette.dart';

ThemeData nesThemeFrom({
  required Brightness brightness,
  required ColorScheme colorScheme,
}) {
  final textTheme = _getTextTheme(brightness);
  return flutterNesTheme(
    brightness: brightness,
    primaryColor: colorScheme.primary,
    nesButtonTheme: NesButtonTheme(
      normal: Color.lerp(
            colorScheme.surface,
            colorScheme.primary,
            0.3,
          ) ??
          colorScheme.primary,
      primary: colorScheme.primary,
      success: colorScheme.primary,
      warning: colorScheme.secondary,
      error: colorScheme.error,
      lightLabelColor: brightness == Brightness.light
          ? colorScheme.onPrimary
          : colorScheme.onSurface,
      darkLabelColor: brightness == Brightness.light
          ? colorScheme.onSurface
          : colorScheme.onPrimary,
      lightIconTheme: brightness == Brightness.light
          ? NesIconTheme(
              primary: colorScheme.onPrimary,
              secondary: colorScheme.primary,
            )
          : NesIconTheme(
              primary: colorScheme.onSurface,
              secondary: colorScheme.background.withOpacity(0.5),
            ),
      darkIconTheme: brightness == Brightness.light
          ? NesIconTheme(
              primary: colorScheme.onSurface,
              secondary: colorScheme.background,
            )
          : NesIconTheme(
              primary: colorScheme.onPrimary,
              secondary: colorScheme.primary.withOpacity(0.5),
            ),
      borderColor: brightness == Brightness.light
          ? colorScheme.onSurface
          : RicochlimePalette.grassColorDark,
    ),
    nesContainerTheme: NesContainerTheme(
      borderColor: RicochlimePalette.grassColorDark,
      backgroundColor: Colors.transparent,
      labelTextStyle: textTheme.labelMedium ?? const TextStyle(),
    ),
    nesIconTheme: NesIconTheme(
      primary: colorScheme.onSurface,
      secondary: colorScheme.onPrimary,
    ),
  ).copyWith(
    useMaterial3: true,
    colorScheme: colorScheme,
    textTheme: textTheme,
  );
}

TextTheme _getTextTheme(Brightness brightness) {
  final baseTheme = ThemeData(brightness: brightness);
  if (Prefs.hyperlegibleFont.value) {
    return GoogleFonts.atkinsonHyperlegibleTextTheme(baseTheme.textTheme);
  } else {
    return GoogleFonts.silkscreenTextTheme(baseTheme.textTheme);
  }
}
