import 'package:flutter/material.dart';
import 'package:inscribe/core/consts.dart';
import 'package:inscribe/core/presentation/app_color_scheme.dart';

class AppButtonStyles {
  BuildContext? context;

  AppButtonStyles.of(this.context);

  ButtonStyle get black {
    return ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
        ),
        foregroundColor: AppColorScheme.of(context).beige,
        backgroundColor: AppColorScheme.of(context).black);
  }

  ButtonStyle get white {
    return ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
        ),
        foregroundColor: AppColorScheme.of(context).gray,
        backgroundColor: AppColorScheme.of(context).beige);
  }

  ButtonStyle get gray {
    return ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
        ),
        foregroundColor: AppColorScheme.of(context).beige,
        backgroundColor: AppColorScheme.of(context).gray);
  }
}
