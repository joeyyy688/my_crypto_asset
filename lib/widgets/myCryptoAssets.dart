// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:my_crypto_asset/constants/app_colors.dart';
import 'package:my_crypto_asset/providers/appStateProvider.dart';
import 'package:my_crypto_asset/widgets/cryptoTile.dart';
import 'package:provider/provider.dart';

class MyCryptoAssets extends StatelessWidget {
  const MyCryptoAssets({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (_, appStateData, __) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Dismissible(
                key: Key(appStateData
                    .getMyWalletData[index].selectedCryptoCurrency.id),
                background: Container(color: AppColor.red),
                onDismissed: (direction) {
                  appStateData.removeWallet(index);
                },
                child: CryptoTile(
                  cryptoImage: appStateData
                      .getMyWalletData[index].selectedCryptoCurrency.image,
                  cryptoName: appStateData
                      .getMyWalletData[index].selectedCryptoCurrency.name,
                  cryptoPrice: appStateData
                      .getMyWalletData[index].myWalletAmountBalance
                      .toDouble(),
                  priceChangeInOneHr: appStateData
                      .getMyWalletData[index]
                      .selectedCryptoCurrency
                      .priceChangePercentage1HInCurrency!,
                  symbol: appStateData
                      .getMyWalletData[index].selectedCryptoCurrency.symbol,
                ),
              );
            },
            childCount: appStateData.getMyWalletData.length,
          ),
        );
      },
    );
  }
}
