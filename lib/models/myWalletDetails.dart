// ignore_for_file: file_names

import 'package:my_crypto_asset/apis/models/coinMarketResponse.dart';

class MyWalletDetails {
  final double myWalletAmountBalance;
  final CoinMarketResponse selectedCryptoCurrency;

  MyWalletDetails({
    required this.myWalletAmountBalance,
    required this.selectedCryptoCurrency,
  });
}
