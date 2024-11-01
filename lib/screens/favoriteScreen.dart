// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_crypto_asset/constants/app_colors.dart';
import 'package:my_crypto_asset/providers/appStateProvider.dart';
import 'package:my_crypto_asset/widgets/cryptoTile.dart';
import 'package:my_crypto_asset/widgets/emptyMessageContainer.dart';
import 'package:my_crypto_asset/widgets/titledAppBar.dart';
import 'package:provider/provider.dart';

class FavouriteCryptoScreen extends StatelessWidget {
  static const routeName = '/favouritesCryptoScreen';
  const FavouriteCryptoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey9,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: TitledAppBar(
          pageTitle: 'Favourite Crypto',
          pageBackButtonCallback: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: CustomScrollView(
          slivers: [
            Consumer<AppState>(
              builder: (_, appStateData, __) {
                if (appStateData.getFavoriteCoinMarketData.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: EmptyContainerMessage(
                      title: 'No Favourite Cryptocurrency Available',
                      subtitle: '',
                    ),
                  );
                } else {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return CryptoTile(
                          cryptoImage: appStateData
                              .getFavoriteCoinMarketData[index].image,
                          cryptoName: appStateData
                              .getFavoriteCoinMarketData[index].name,
                          cryptoPrice: appStateData
                              .getFavoriteCoinMarketData[index].currentPrice!,
                          priceChangeInOneHr: appStateData
                              .getFavoriteCoinMarketData[index]
                              .priceChangePercentage1HInCurrency!,
                          symbol: appStateData
                              .getFavoriteCoinMarketData[index].symbol,
                        );
                      },
                      childCount: appStateData.getFavoriteCoinMarketData.length,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
