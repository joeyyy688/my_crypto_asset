// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_crypto_asset/constants/app_textSizes.dart';

class EmptyContainerMessage extends StatelessWidget {
  final String title;
  final String subtitle;
  final double paddingTopValue;

  const EmptyContainerMessage({
    super.key,
    required this.title,
    required this.subtitle,
    this.paddingTopValue = 140.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: paddingTopValue),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: AppTextSizes.paragraphText1Medium,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          if (subtitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: AppTextSizes.paragraphText2,
                    fontWeight: FontWeight.w200),
              ),
            ),
        ],
      ),
    );
  }
}
