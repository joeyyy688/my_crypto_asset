import 'package:flutter/material.dart';
import 'package:my_crypto_asset/constants/app_colors.dart';
import 'package:my_crypto_asset/constants/app_textSizes.dart';

InputDecoration filledInputDecoration({
  String? hint = '',
  String? helperText,
  Widget? suffixText,
  Widget? suffixIcon,
  Widget? prefixIcon,
}) {
  return InputDecoration(
    prefix: prefixIcon,
    hintText: hint,
    hintStyle: const TextStyle(
      color: AppColor.grey5,
      fontFamily: 'Brandon Grotesque',
      fontSize: AppTextSizes.paragraphText2Medium,
      fontWeight: FontWeight.w100,
    ),
    helperText: helperText,
    suffixIconConstraints: const BoxConstraints(minHeight: 20, minWidth: 30),
    suffix: suffixText,
    suffixIcon: suffixIcon,
    suffixStyle: const TextStyle(color: Colors.black),
    labelStyle: const TextStyle(
      color: Color(0xFFA3AEB8),
    ),
    errorStyle: const TextStyle(),
    errorMaxLines: 4,
    helperMaxLines: 4,
    contentPadding: const EdgeInsets.symmetric(vertical: 17, horizontal: 10),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: Color(0XFFE3E6EA),
      ),
    ),
    disabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: Color(0XFFE3E6EA),
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: Colors.black),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: Colors.black),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: Colors.red,
      ),
    ),
  );
}
