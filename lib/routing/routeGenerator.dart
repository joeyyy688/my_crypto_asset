// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_crypto_asset/apis/models/coinMarketResponse.dart';
import 'package:my_crypto_asset/screens/cryptoDetailsScreen.dart';
import 'package:my_crypto_asset/screens/favoriteScreen.dart';
import 'package:my_crypto_asset/screens/fundCrptoWalletScreen.dart';
import 'package:my_crypto_asset/screens/homeScreen.dart';
import 'package:my_crypto_asset/screens/loginScreen.dart';
import 'package:my_crypto_asset/screens/myWalletPieChartScreen.dart';
import 'routeErrorScreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case HomeScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case FundCryptoWalletScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const FundCryptoWalletScreen(),
        );
      case CryptoDetailsScreen.routeName:
        //
        // Data being passed through the arguments constructor from the .pushNamed method
        final data = args as Map<String, dynamic>;
        //
        return MaterialPageRoute(
          builder: (context) => CryptoDetailsScreen(
            cryptoCurrencyData:
                data['cryptoCurrencyData'] as CoinMarketResponse,
          ),
        );
      case FavouriteCryptoScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const FavouriteCryptoScreen(),
        );
      case MyWalletPieChartScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const MyWalletPieChartScreen(),
        );
      default:
        _errorRoute();
        break;
    }
    return _errorRoute();
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) => const RouteErrorPage());
  }
}
