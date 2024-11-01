// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_crypto_asset/constants/app_colors.dart';
import 'package:my_crypto_asset/constants/app_textSizes.dart';
import 'package:my_crypto_asset/providers/appStateProvider.dart';
import 'package:my_crypto_asset/screens/myWalletPieChartScreen.dart';
import 'package:provider/provider.dart';

class TotalBalanceCard extends StatefulWidget {
  const TotalBalanceCard({super.key});

  @override
  State<TotalBalanceCard> createState() => _TotalBalanceCardState();
}

class _TotalBalanceCardState extends State<TotalBalanceCard> {
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
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (_, appStateData, __) {
        if (appStateData.getSelectedHomeWallet == null ||
            appStateData.getMyWalletData.isEmpty) {
          return const SizedBox.shrink();
        } else {
          _calculateFormattedPercentage(appStateData.getSelectedHomeWallet!
              .selectedCryptoCurrency.priceChangePercentage1HInCurrency!
              .toDouble());
          return Container(
            decoration: BoxDecoration(
              color: AppColor.grey8,
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Text(
                        '${appStateData.getSelectedHomeWallet!.selectedCryptoCurrency.name} Wallet',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w300,
                              fontSize: AppTextSizes.buttonTextRegular,
                              color: AppColor.grey1,
                            ),
                      ),
                      PopupMenuButton(
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          size: 20,
                          color: AppColor.grey1,
                        ),
                        itemBuilder: (context) {
                          return [
                            ...appStateData.getMyWalletData
                                .asMap()
                                .map((i, element) => MapEntry(
                                    i,
                                    PopupMenuItem(
                                      value: i,
                                      child: Text(
                                        element.selectedCryptoCurrency.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: AppColor.grey2,
                                              fontWeight: FontWeight.w400,
                                              fontSize: AppTextSizes.labelText1,
                                            ),
                                      ),
                                    )))
                                .values
                          ];
                        },
                        onSelected: (value) {
                          appStateData.setMySelectedHomeWallet(
                              appStateData.getMyWalletData[value]);
                        },
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(MyWalletPieChartScreen.routeName);
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(Icons.pie_chart_rounded),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                      amountFormatter(appStateData
                          .getSelectedHomeWallet!.myWalletAmountBalance),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 36,
                            color: AppColor.grey1,
                          ),
                    ),
                    const SizedBox(width: 10),
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: AppColor.green2,
                                    fontWeight: FontWeight.w400,
                                    fontSize: AppTextSizes.labelText2),
                          ),
                        }
                      ],
                    )
                  ],
                ),
                Text(
                  '≈ ${(appStateData.getSelectedHomeWallet!.myWalletAmountBalance / appStateData.getSelectedHomeWallet!.selectedCryptoCurrency.currentPrice!.toDouble())} ${appStateData.getSelectedHomeWallet!.selectedCryptoCurrency.symbol.toUpperCase()}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColor.grey3,
                        fontWeight: FontWeight.w500,
                        fontSize: AppTextSizes.title3Semibold,
                      ),
                ),
                const SizedBox(height: 8),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontSize: AppTextSizes.labelText1,
                                    fontWeight: FontWeight.w100,
                                    color: AppColor.grey4,
                                  ),
                            ),
                            Text(
                              '\$ ${amountFormatter(appStateData.getSelectedHomeWallet!.selectedCryptoCurrency.ath!.toDouble())}',
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontSize: AppTextSizes.labelText1,
                                    fontWeight: FontWeight.w100,
                                    color: AppColor.grey4,
                                  ),
                            ),
                            Text(
                              '\$ ${amountFormatter(appStateData.getSelectedHomeWallet!.selectedCryptoCurrency.high24H!.toDouble())}',
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontSize: AppTextSizes.labelText1,
                                    fontWeight: FontWeight.w100,
                                    color: AppColor.grey4,
                                  ),
                            ),
                            Text(
                              '\$ ${amountFormatter(appStateData.getSelectedHomeWallet!.selectedCryptoCurrency.low24H!.toDouble())}',
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
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
                const SizedBox(height: 22),
              ],
            ),
          );
        }
      },
    );
  }
}
