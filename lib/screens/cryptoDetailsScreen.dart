// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_crypto_asset/apis/models/coinMarketResponse.dart';
import 'package:my_crypto_asset/constants/app_colors.dart';
import 'package:my_crypto_asset/constants/app_textSizes.dart';
import 'package:my_crypto_asset/providers/appStateProvider.dart';
import 'package:my_crypto_asset/widgets/buttons/iconButton.dart';
import 'package:my_crypto_asset/widgets/titledAppBar.dart';
import 'package:provider/provider.dart';

class CryptoDetailsScreen extends StatefulWidget {
  static const routeName = '/cryptoDetailsScreen';

  final CoinMarketResponse cryptoCurrencyData;

  const CryptoDetailsScreen({super.key, required this.cryptoCurrencyData});

  @override
  State<CryptoDetailsScreen> createState() => _CryptoDetailsScreenState();
}

class _CryptoDetailsScreenState extends State<CryptoDetailsScreen> {
  String formattedPercentage = '';
  bool isNegative = false;

  void _calculateFormattedPercentage(double priceChangeInOneHr) {
    double percentage = _convertToPercentage(priceChangeInOneHr);
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
  void initState() {
    // implement initState
    super.initState();
    _calculateFormattedPercentage(widget
        .cryptoCurrencyData.priceChangePercentage1HInCurrency!
        .toDouble());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey9,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: TitledAppBar(
          pageTitle: 'Price Chart',
          pageBackButtonCallback: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                    imageUrl: widget.cryptoCurrencyData.image,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            const CupertinoActivityIndicator(
                                color: AppColor.primary),
                    errorWidget: (_, __, ___) =>
                        const CupertinoActivityIndicator(
                            color: AppColor.primary),
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  '\$',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: AppTextSizes.title2SemiBold,
                        color: AppColor.grey1,
                      ),
                ),
                const SizedBox(width: 4),
                Text(
                  amountFormatter(
                      widget.cryptoCurrencyData.currentPrice!.toDouble()),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 36,
                        color: AppColor.grey1,
                      ),
                ),
                const SizedBox(width: 20),
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
                )
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ATH',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: AppTextSizes.labelText1,
                                    fontWeight: FontWeight.w100,
                                    color: AppColor.grey4,
                                  ),
                        ),
                        Text(
                          '\$ ${amountFormatter(widget.cryptoCurrencyData.ath!.toDouble())}',
                          textAlign: TextAlign.left,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColor.grey3,
                                    fontWeight: FontWeight.w500,
                                    fontSize: AppTextSizes.paragraphText2,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '24Hr High',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: AppTextSizes.labelText1,
                                    fontWeight: FontWeight.w100,
                                    color: AppColor.grey4,
                                  ),
                        ),
                        Text(
                          '\$ ${amountFormatter(widget.cryptoCurrencyData.high24H!.toDouble())}',
                          textAlign: TextAlign.left,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColor.grey3,
                                    fontWeight: FontWeight.w500,
                                    fontSize: AppTextSizes.paragraphText2,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '24Hr Low',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: AppTextSizes.labelText1,
                                    fontWeight: FontWeight.w100,
                                    color: AppColor.grey4,
                                  ),
                        ),
                        Text(
                          '\$ ${amountFormatter(widget.cryptoCurrencyData.low24H!.toDouble())}',
                          textAlign: TextAlign.left,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColor.grey3,
                                    fontWeight: FontWeight.w500,
                                    fontSize: AppTextSizes.paragraphText2,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Sparkline(
              data: widget.cryptoCurrencyData.sparklineIn7D?.price ?? [],
              gridLinelabelPrefix: ' \$',
              gridLinelabelSuffix: '',
              gridLineLabelPrecision: 2,
              gridLinesEnable: true,
              gridLineLabelFixed: true,
              cubicSmoothingFactor: 0.3,
              fillMode: FillMode.below,
              lineWidth: 2,
              fallbackHeight: 380,
              averageLine: true,
              averageLabel: true,
              pointsMode: PointsMode.last,
              useCubicSmoothing: true,
              sharpCorners: true,
            ),
            const SizedBox(height: 30),
            Consumer<AppState>(
              builder: (_, appStateData, __) {
                bool isCoinAbsent = appStateData.getFavoriteCoinMarketData.any(
                    (coin) =>
                        coin.symbol.toLowerCase() ==
                        widget.cryptoCurrencyData.symbol.toLowerCase());

                if (!isCoinAbsent) {
                  return CustomIconButton(
                    icon: Icons.add,
                    label:
                        'Add ${widget.cryptoCurrencyData.symbol.toUpperCase()} to favorites',
                    onPressed: () {
                      appStateData
                          .addToFavouriteWalletData(widget.cryptoCurrencyData);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Added ${widget.cryptoCurrencyData.symbol.toUpperCase()} to list of favorites',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: AppColor.grey9,
                                  fontSize: AppTextSizes.labelText1,
                                ),
                          ),
                          backgroundColor: AppColor.primary,
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 5),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
