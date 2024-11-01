// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_crypto_asset/apis/generics/httpGenericRequest.dart';
import 'package:my_crypto_asset/apis/models/coinMarketResponse.dart';
import 'package:my_crypto_asset/constants/app_apiConstants.dart';

class CryptoServices {
  static Future<List<CoinMarketResponse?>?> fetchCurrentCoinMarket() async {
    try {
      final response = await const GenericRequest(
        method: RequestMethods.get,
        authApiCalls: true,
        url: AppApiConstants.fetchCoinMarketUrl,
      ).makeApiCall();

      if (response.statusCode == 200) {
        return [
          for (final item in response.body) CoinMarketResponse.fromJson(item)
        ];
      } else {
        return null;
      }
    } catch (e, stack) {
      debugPrint(stack.toString());
    }
    return null;
  }
}
