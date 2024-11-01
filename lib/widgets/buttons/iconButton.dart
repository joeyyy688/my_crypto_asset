// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_crypto_asset/constants/app_colors.dart';
import 'package:my_crypto_asset/constants/app_textSizes.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color backgroundColor;
  final Color labelColor;
  final Color iconColor;
  final IconData icon;

  const CustomIconButton({
    super.key,
    this.onPressed,
    required this.label,
    required this.icon,
    this.backgroundColor = AppColor.primary,
    this.labelColor = AppColor.grey9,
    this.iconColor = AppColor.grey9,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 200,
        padding: const EdgeInsets.only(
          top: 12,
          left: 14,
          right: 16,
          bottom: 12,
        ),
        decoration: ShapeDecoration(
          color: onPressed == null ? AppColor.grey5 : backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: onPressed == null ? AppColor.grey9 : iconColor,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: AppTextSizes.labelText1Medium,
                    color: onPressed == null ? AppColor.grey9 : labelColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
