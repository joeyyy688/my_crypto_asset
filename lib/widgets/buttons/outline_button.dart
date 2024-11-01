import 'package:flutter/material.dart';
import 'package:my_crypto_asset/constants/app_colors.dart';

class ButtonOutline extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color? borderColor;
  final Color? textColor;
  final double? buttonOutlineHeight;
  final TextStyle? outlineButtonTextStyle;

  const ButtonOutline({
    super.key,
    required this.label,
    this.onPressed,
    this.borderColor,
    this.textColor,
    this.outlineButtonTextStyle,
    this.buttonOutlineHeight = 50,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    const color = Color(0xffD6D6D6);

    return SizedBox(
      height: buttonOutlineHeight,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          side: WidgetStateProperty.all(
            BorderSide(
                color: onPressed != null
                    ? (borderColor ?? AppColor.primary)
                    : color),
          ),
        ),
        child: Text(
          label,
          style: outlineButtonTextStyle ??
              themeData.textTheme.labelLarge!.copyWith(
                color:
                    onPressed == null ? color : (textColor ?? AppColor.primary),
              ),
        ),
      ),
    );
  }
}
