// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_crypto_asset/constants/app_colors.dart';
import 'package:my_crypto_asset/constants/app_textSizes.dart';
import 'package:my_crypto_asset/widgets/inputs/input_decoration.dart';
import 'package:my_crypto_asset/widgets/inputs/input_validator.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.onSaved,
    this.onChanged,
    this.initialValue,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.obscuringCharater = '*',
    this.inputFormatters,
    this.textCaps = TextCapitalization.sentences,
    this.textInputAction = TextInputAction.done,
    this.isRequired = true,
    this.autoFocus = false,
    this.maxLines,
    this.minLines,
    this.onValidate,
    this.prefix,
    this.controller,
    this.labelForValidation,
    this.onSubmitted,
    this.autofillHints,
    this.suffix,
    this.focusNode,
    this.textFieldOnTap,
    this.enabled,
    this.readOnly = false,
    this.textFieldStyle = const TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: 'Brandon Grotesque',
        color: AppColor.primary,
        fontSize: AppTextSizes.paragraphText2Medium),
    this.validationLabel,
    required this.hint,
  });

  final Function(String value)? onSaved;
  final String? Function(String value)? onValidate;
  final String? initialValue;
  final String? validationLabel;
  final String? labelForValidation;
  final Widget? prefix;
  final Function(String value)? onSubmitted;
  final Function(String value)? onChanged;
  final bool obscureText;
  final String obscuringCharater;
  final TextInputType textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization? textCaps;
  final TextInputAction textInputAction;
  final bool isRequired, autoFocus;
  final int? maxLines;
  final int? minLines;
  final TextEditingController? controller;
  final Widget? suffix;
  final String hint;
  final List<String>? autofillHints;
  final FocusNode? focusNode;
  final void Function()? textFieldOnTap;
  final bool? enabled;
  final bool readOnly;
  final TextStyle? textFieldStyle;

  @override
  Widget build(BuildContext context) {
    TextCapitalization _textCaps = textCaps ?? TextCapitalization.none;

    if (textInputType == TextInputType.text && textCaps == null) {
      _textCaps = TextCapitalization.words;
    }
    int? _maxLines = maxLines;
    if (obscureText) {
      _maxLines = 1;
    }
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      textInputAction: textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: textFieldStyle,
      textCapitalization: _textCaps,
      enabled: enabled,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharater,
      autofocus: autoFocus,
      maxLines: _maxLines,
      minLines: minLines,
      inputFormatters: inputFormatters,
      autofillHints: autofillHints,
      onChanged: (value) {
        if (onChanged == null) return;
        onChanged!.call(value);
      },
      onSaved: (value) {
        if (value == null || onSaved == null) return;
        onSaved!(value);
      },
      initialValue: initialValue,
      onFieldSubmitted: onSubmitted,
      validator: (value) {
        if (!isRequired && (value?.trim().isEmpty ?? true)) return null;
        //final _label = labelForValidation ?? validationLabel;

        String? _errorMsg;

        if (textInputType == TextInputType.emailAddress) {
          if (!value!.isEmail) {
            _errorMsg = validationLabel;
          }
          _errorMsg = validationLabel;
        } else if (textInputType == TextInputType.phone) {
          if (!value!.isPhoneNumber) {
            _errorMsg = validationLabel;
          }
          _errorMsg = validationLabel;
        } else {
          //if (value!.trim().isEmpty) _errorMsg = '$_label is required';
          //validationLabel
          //if (value.trim().isEmpty) _errorMsg = validationLabel;
          _errorMsg = validationLabel;
        }

        if (_errorMsg == null && onValidate != null) {
          _errorMsg = onValidate!(value!);
        }

        return _errorMsg;
      },
      keyboardType: textInputType,
      decoration: filledInputDecoration(hint: hint).copyWith(
        prefixIcon: prefix,
        //prefix: prefix,
        suffixIcon: suffix,
      ),
      readOnly: readOnly,
      onTap: textFieldOnTap,
    );
  }
}
