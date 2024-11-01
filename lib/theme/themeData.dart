// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_crypto_asset/constants/app_colors.dart';
import 'package:my_crypto_asset/constants/app_textSizes.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColor.primary,
    scaffoldBackgroundColor: AppColor.grey9,
    useMaterial3: true,
    dividerTheme:
        Theme.of(context).dividerTheme.copyWith(color: AppColor.grey7),
    dialogTheme: Theme.of(context).dialogTheme.copyWith(
          elevation: 5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(0.0),
            ),
          ),
        ),
    textTheme: Theme.of(context)
        .textTheme
        .apply(
          bodyColor: AppColor.primary,
          displayColor: AppColor.grey9,
        )
        .copyWith(
          displayLarge: const TextStyle(
            fontSize: AppTextSizes.display1SemiBold,
            color: AppColor.grey9,
            fontFamily: 'Big Caslon',
            fontWeight: FontWeight.w400,
          ),
          bodyLarge: const TextStyle(
              fontSize: AppTextSizes.title1SemiBold,
              fontWeight: FontWeight.w400,
              color: AppColor.primary,
              fontFamily: 'Big Caslon'),
          bodyMedium: const TextStyle(
              fontSize: AppTextSizes.paragraphText2Medium,
              color: AppColor.primary,
              fontFamily: 'Brandon Grotesque'),
          labelLarge: const TextStyle(
              fontSize: AppTextSizes.buttonTextRegular,
              fontWeight: FontWeight.w600,
              color: AppColor.grey9,
              fontFamily: 'Brandon Grotesque'),
        ),
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.light,
    ).copyWith(
      secondary: AppColor.grey9,
      error: AppColor.red,
      surface: AppColor.grey9,
    ),
  );
}
