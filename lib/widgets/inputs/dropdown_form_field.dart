// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:my_crypto_asset/constants/app_colors.dart';
import 'package:my_crypto_asset/constants/app_textSizes.dart';
import 'package:my_crypto_asset/widgets/inputs/input_decoration.dart';

/// A convenience widget that makes a [DropdownButton] into a [FormField].
class CustomDropDownFormField<T> extends FormField<T> {
  /// Creates a [DropdownButton] widget that is a [FormField], wrapped in an
  /// [InputDecorator].
  ///
  /// For a description of the `onSaved`, `validator`, or `autovalidateMode`
  /// parameters, see [FormField]. For the rest (other than [decoration]), see
  /// [DropdownButton].
  ///
  /// The `items`, `elevation`, `iconSize`, `isDense`, `isExpanded`,
  /// `autofocus`, and `decoration`  parameters must not be null.
  CustomDropDownFormField({
    super.key,
    required List<T>? items,
    DropdownButtonBuilder? selectedItemBuilder,
    String hint = '',
    super.initialValue,
    Widget? disabledHint,
    this.onChanged,
    VoidCallback? onTap,
    int elevation = 8,
    TextStyle? style,
    Color? iconDisabledColor,
    Color? iconEnabledColor,
    double iconSize = 24.0,
    bool isDense = true,
    bool isExpanded = false,
    bool isRequired = true,
    double? itemHeight,
    Color? focusColor,
    FocusNode? focusNode,
    bool autofocus = false,
    Color? dropdownColor,
    InputDecoration? decoration,
    super.onSaved,
    FormFieldValidator<T>? validator,
    Widget? icon,
    required DropdownMenuItem<T> Function(T item) buildItem,
    @Deprecated(
      'Use autovalidateMode parameter which provide more specific '
      'behaviour related to auto validation. '
      'This feature was deprecated after v1.19.0.',
    )
    bool autovalidate = true,
    AutovalidateMode? autovalidateMode,
    double? menuMaxHeight,
  })  : assert(itemHeight == null || itemHeight >= kMinInteractiveDimension),
        assert(
          autovalidate == false ||
              autovalidate == true && autovalidateMode == null,
          'autovalidate and autovalidateMode should not be used together.',
        ),
        decoration = decoration ?? InputDecoration(focusColor: focusColor),
        super(
          validator: (value) {
            if (isRequired && (value == null)) return '$hint is required';
            return null;
          },
          autovalidateMode: autovalidate
              ? AutovalidateMode.onUserInteraction
              : (autovalidateMode ?? AutovalidateMode.disabled),
          builder: (FormFieldState<T> field) {
            final _DropdownButtonFormFieldState<T> state =
                field as _DropdownButtonFormFieldState<T>;
            final InputDecoration decorationArg =
                decoration ?? filledInputDecoration();
            final InputDecoration effectiveDecoration =
                decorationArg.applyDefaults(
              Theme.of(field.context).inputDecorationTheme,
            );
            // An unfocusable Focus widget so that this widget can detect if its
            // descendants have focus or not.
            return Focus(
              canRequestFocus: false,
              skipTraversal: true,
              child: Builder(builder: (BuildContext context) {
                return InputDecorator(
                  decoration:
                      effectiveDecoration.copyWith(errorText: field.errorText),
                  isEmpty: state.value == null,
                  isFocused: Focus.of(context).hasFocus,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<T>(
                      items: items!.map((p) => buildItem(p)).toList(),
                      selectedItemBuilder: selectedItemBuilder,
                      value: state.value,
                      hint: Text(
                        hint,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColor.grey5,
                            fontSize: AppTextSizes.paragraphText2,
                            fontWeight: FontWeight.w100),
                      ),
                      disabledHint: disabledHint,
                      onChanged: (value) {
                        state.didChange(value);
                        if (onChanged != null) onChanged(value);
                        FocusScope.of(context).nextFocus();
                      },
                      onTap: onTap,
                      elevation: elevation,
                      style: style,
                      icon: icon,
                      iconDisabledColor: iconDisabledColor,
                      iconEnabledColor: iconEnabledColor,
                      iconSize: iconSize,
                      isDense: isDense,
                      isExpanded: isExpanded,
                      itemHeight: itemHeight,
                      focusColor: focusColor,
                      focusNode: focusNode,
                      autofocus: autofocus,
                      dropdownColor: dropdownColor,
                      menuMaxHeight: menuMaxHeight,
                    ),
                  ),
                );
              }),
            );
          },
        );

  /// {@macro flutter.material.dropdownButton.onChanged}
  final ValueChanged<T?>? onChanged;

  /// The decoration to show around the dropdown button form field.
  ///
  /// By default, draws a horizontal line under the dropdown button field but
  /// can be configured to show an icon, label, hint text, and error text.
  ///
  /// If not specified, an [InputDecorator] with the `focusColor` set to the
  /// supplied `focusColor` (if any) will be used.
  final InputDecoration decoration;

  @override
  FormFieldState<T> createState() => _DropdownButtonFormFieldState<T>();
}

class _DropdownButtonFormFieldState<T> extends FormFieldState<T> {
  @override
  CustomDropDownFormField<T> get widget =>
      super.widget as CustomDropDownFormField<T>;

  @override
  void didChange(T? value) {
    super.didChange(value);
    assert(widget.onChanged != null);
    widget.onChanged!(value);
  }

  @override
  void didUpdateWidget(CustomDropDownFormField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      setValue(widget.initialValue);
    }
  }
}
