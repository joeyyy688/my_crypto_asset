// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_crypto_asset/apis/models/coinMarketResponse.dart';
import 'package:my_crypto_asset/constants/app_colors.dart';
import 'package:my_crypto_asset/constants/app_textSizes.dart';
import 'package:my_crypto_asset/models/myWalletDetails.dart';
import 'package:my_crypto_asset/providers/appStateProvider.dart';
import 'package:my_crypto_asset/widgets/buttons/primary_button.dart';
import 'package:my_crypto_asset/widgets/inputLabel.dart';
import 'package:my_crypto_asset/widgets/inputs/dropdown_form_field.dart';
import 'package:my_crypto_asset/widgets/inputs/text_form_field.dart';
import 'package:my_crypto_asset/widgets/titledAppBar.dart';
import 'package:provider/provider.dart';

class FundCryptoWalletScreen extends StatefulWidget {
  static const routeName = '/fundCryptoWalletScreen';
  const FundCryptoWalletScreen({super.key});

  @override
  State<FundCryptoWalletScreen> createState() => _FundCryptoWalletScreenState();
}

class _FundCryptoWalletScreenState extends State<FundCryptoWalletScreen> {
  final amountController = TextEditingController(text: '0');
  CoinMarketResponse? selectedCrypoCoin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey9,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: TitledAppBar(
          pageTitle: 'Fund Crypto Wallet',
          pageBackButtonCallback: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputLabel(
              label: 'Amount',
              labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColor.grey4,
                    fontWeight: FontWeight.w100,
                  ),
            ),
            const SizedBox(height: 5),
            CustomTextFormField(
              controller: amountController,
              textCaps: TextCapitalization.none,
              textInputType: TextInputType.number,
              validationLabel: null,
              hint: 'Enter Amount (USD)',
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
            ),
            const SizedBox(height: 30),
            InputLabel(
              label: 'Cryptocurrency Coin',
              labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColor.grey4,
                    fontWeight: FontWeight.w100,
                  ),
            ),
            Consumer<AppState>(builder: (_, appStateData, __) {
              return CustomDropDownFormField<CoinMarketResponse?>(
                items: appStateData.getCoinMarketData,
                buildItem: (item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item!.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Brandon Grotesque',
                      color: AppColor.primary,
                      fontSize: AppTextSizes.paragraphText2Medium,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    selectedCrypoCoin = value;
                  });
                },
              );
            }),
            const SizedBox(height: 30),
            if (selectedCrypoCoin != null) ...{
              InputLabel(
                label: '${selectedCrypoCoin!.symbol.toUpperCase()} Value',
                labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColor.grey4,
                      fontWeight: FontWeight.w100,
                    ),
              ),
              ValueListenableBuilder(
                valueListenable: amountController,
                builder: (_, value, __) {
                  final inputValue =
                      value.text.isEmpty ? '0' : value.text.trim();
                  return CustomTextFormField(
                    enabled: false,
                    controller: TextEditingController(
                        text: (double.parse(inputValue) /
                                selectedCrypoCoin!.currentPrice!.toDouble())
                            .toString()),
                    textCaps: TextCapitalization.none,
                    textInputType: TextInputType.number,
                    validationLabel: null,
                    hint: '',
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                  );
                },
              ),
            },
            const Spacer(),
            ValueListenableBuilder(
                valueListenable: amountController,
                builder: (_, value, __) {
                  final isButtonEnabled =
                      value.text.trim().isNotEmpty && selectedCrypoCoin != null;

                  final inputValue =
                      value.text.isEmpty ? '0' : value.text.trim();
                  return PrimaryButton(
                    isLoading: false,
                    label: 'ADD ',
                    onPressed: isButtonEnabled
                        ? () async {
                            // if keyboard is showing hide it
                            FocusScope.of(context).unfocus();

                            final walletData = MyWalletDetails(
                              myWalletAmountBalance: double.parse(inputValue),
                              selectedCryptoCurrency: selectedCrypoCoin!,
                            );

                            final appStateProvider =
                                Provider.of<AppState>(context, listen: false);

                            if (appStateProvider.getSelectedHomeWallet ==
                                null) {
                              appStateProvider
                                  .setMySelectedHomeWallet(walletData);
                            }

                            appStateProvider.addToMyWalletData(walletData);

                            Navigator.of(context).pop();
                          }
                        : null,
                  );
                }),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
