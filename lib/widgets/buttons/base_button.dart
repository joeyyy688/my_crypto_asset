import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_crypto_asset/constants/app_colors.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    super.key,
    this.onPressed,
    required this.label,
    required this.backgroundColor,
    required this.labelColor,
    this.isLoading = false,
    this.loaderColor = AppColor.grey9,
  });

  final VoidCallback? onPressed;
  final String label;
  final Color backgroundColor;
  final Color labelColor;
  final bool isLoading;
  final Color loaderColor;

  @override
  Widget build(BuildContext context) {
    Color getBgColor(Set<WidgetState> states) {
      if (states.any((e) => e == WidgetState.disabled)) {
        return const Color(0xFFE3E6EA);
      }

      return backgroundColor;
    }

    // Color getTextColor(Set<MaterialState> states) {
    //   if (states.any((e) => e == MaterialState.disabled)) {
    //     return Color(0xFF000000);
    //   }

    //   return labelColor;
    // }

    return SizedBox(
      height: 54,
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith(getBgColor),
          // foregroundColor: MaterialStateProperty.resolveWith(getTextColor),
        ),
        child: isLoading
            ? CupertinoActivityIndicator(
                color: loaderColor,
                radius: 13,
              )
            : Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: labelColor, fontSize: 14),
              ),
      ),
    );
  }
}
