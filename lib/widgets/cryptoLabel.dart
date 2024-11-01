// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_crypto_asset/constants/app_colors.dart';
import 'package:my_crypto_asset/widgets/label.dart';

class CryptoLabel extends StatelessWidget {
  final String labelText;

  const CryptoLabel({super.key, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 0, top: 0),
            child: Divider(
              color: AppColor.grey7,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                Label(
                  labelText: labelText,
                  labelPaddingBottom: 0,
                ),
                const Spacer(),
                const Label(
                  labelText: 'Prices',
                  labelPaddingBottom: 0,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 0, top: 0),
            child: Divider(
              color: AppColor.grey7,
            ),
          ),
        ],
      ),
    );
  }
}
