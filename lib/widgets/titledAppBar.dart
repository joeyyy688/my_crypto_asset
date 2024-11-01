// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_crypto_asset/constants/app_colors.dart';
import 'package:my_crypto_asset/constants/app_textSizes.dart';

class TitledAppBar extends StatelessWidget {
  final String pageTitle;
  final Function pageBackButtonCallback;
  const TitledAppBar({
    super.key,
    required this.pageTitle,
    required this.pageBackButtonCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 54, bottom: 12),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            GestureDetector(
                onTap: () => pageBackButtonCallback.call(),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppColor.grey1,
                )),
            const Spacer(),
            Text(
              pageTitle,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: AppTextSizes.paragraphText2,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
