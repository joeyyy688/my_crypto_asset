// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:my_crypto_asset/providers/appStateProvider.dart';
import 'package:my_crypto_asset/screens/cryptoDetailsScreen.dart';
import 'package:my_crypto_asset/widgets/cryptoTile.dart';
import 'package:provider/provider.dart';

class CryptoCoins extends StatelessWidget {
  const CryptoCoins({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (_, appStateData, __) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    CryptoDetailsScreen.routeName,
                    arguments: {
                      'cryptoCurrencyData':
                          appStateData.getCoinMarketData[index]!,
                    },
                  );
                },
                child: CryptoTile(
                  cryptoImage: appStateData.getCoinMarketData[index]!.image,
                  cryptoName: appStateData.getCoinMarketData[index]!.name,
                  cryptoPrice: appStateData
                      .getCoinMarketData[index]!.currentPrice!
                      .toDouble(),
                  priceChangeInOneHr: appStateData.getCoinMarketData[index]!
                      .priceChangePercentage1HInCurrency!,
                  symbol: appStateData.getCoinMarketData[index]!.symbol,
                ),
              );
            },
            childCount: appStateData.getCoinMarketData.length,
          ),
        );
      },
    );
  }
}
