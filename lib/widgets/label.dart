import 'package:flutter/material.dart';
import 'package:my_crypto_asset/constants/app_colors.dart';
import 'package:my_crypto_asset/constants/app_textSizes.dart';
import 'package:my_crypto_asset/widgets/inputLabel.dart';

class Label extends StatelessWidget {
  final String labelText;
  final double labelTextSize;
  final Color labelColor;
  final FontWeight labelFontWeight;
  final double labelPaddingBottom;

  const Label({
    super.key,
    required this.labelText,
    this.labelTextSize = AppTextSizes.paragraphText1Medium,
    this.labelColor = AppColor.primary,
    this.labelFontWeight = FontWeight.w400,
    required this.labelPaddingBottom,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: labelPaddingBottom),
      child: InputLabel(
        label: labelText,
        labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: labelColor,
            fontWeight: labelFontWeight,
            fontSize: labelTextSize),
      ),
    );
  }
}
