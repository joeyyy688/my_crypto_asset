// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_crypto_asset/constants/app_colors.dart';
import 'package:my_crypto_asset/constants/app_textSizes.dart';

class CryptoTile extends StatefulWidget {
  final String cryptoImage;
  final String symbol;
  final num cryptoPrice;
  final num priceChangeInOneHr;
  final String cryptoName;

  const CryptoTile({
    super.key,
    required this.cryptoImage,
    required this.symbol,
    required this.cryptoPrice,
    required this.priceChangeInOneHr,
    required this.cryptoName,
  });

  @override
  State<CryptoTile> createState() => _CryptoTileState();
}

class _CryptoTileState extends State<CryptoTile> {
  late String formattedPercentage;
  late bool isNegative;

  @override
  void initState() {
    super.initState();
    _calculateFormattedPercentage();
  }

  void _calculateFormattedPercentage() {
    double percentage =
        _convertToPercentage(widget.priceChangeInOneHr.toDouble());
    formattedPercentage = _formatToTwoDecimals(percentage.abs());
    isNegative = percentage < 0;
  }

  double _convertToPercentage(double value) {
    return value;
  }

  String _formatToTwoDecimals(double value) {
    return value.toStringAsFixed(2);
  }

  String amountFormatter(double amount) {
    NumberFormat formatter = NumberFormat.decimalPatternDigits(
      locale: 'en',
      decimalDigits: 2,
    );

    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 22),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: AppColor.grey8,
            child: CachedNetworkImage(
              imageBuilder: (context, imageProvider) => Container(
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              imageUrl: widget.cryptoImage,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  const CupertinoActivityIndicator(color: AppColor.primary),
              errorWidget: (_, __, ___) =>
                  const CupertinoActivityIndicator(color: AppColor.primary),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.cryptoName,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColor.grey3,
                      fontWeight: FontWeight.w100,
                      fontSize: AppTextSizes.paragraphText2,
                    ),
              ),
              Text(
                widget.symbol.toUpperCase(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColor.grey3,
                    fontWeight: FontWeight.w400,
                    fontSize: AppTextSizes.paragraphText2),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$ ${amountFormatter(widget.cryptoPrice.toDouble())}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColor.grey3,
                      fontWeight: FontWeight.w400,
                      fontSize: AppTextSizes.paragraphText2,
                    ),
              ),
              Row(
                children: [
                  if (isNegative) ...{
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColor.red,
                      size: 20,
                    ),
                    Text(
                      '$formattedPercentage%',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColor.red,
                          fontWeight: FontWeight.w400,
                          fontSize: AppTextSizes.labelText2),
                    ),
                  } else ...{
                    const Icon(
                      Icons.keyboard_arrow_up,
                      color: AppColor.green2,
                      size: 20,
                    ),
                    Text(
                      '$formattedPercentage%',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColor.green2,
                          fontWeight: FontWeight.w400,
                          fontSize: AppTextSizes.labelText2),
                    ),
                  }
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
