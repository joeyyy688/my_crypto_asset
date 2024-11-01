// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_crypto_asset/apis/models/coinMarketResponse.dart';
import 'package:my_crypto_asset/models/myWalletDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState with ChangeNotifier {
  //Local Variables
  List<CoinMarketResponse?>? _coinMarketData;
  final List<MyWalletDetails> _myWalletData = [];
  MyWalletDetails? _selectedHomeWallet;
  List<CoinMarketResponse> _favoriteCoinMarketData = [];

  //Getters
  List<CoinMarketResponse?> get getCoinMarketData => _coinMarketData ?? [];
  List<MyWalletDetails> get getMyWalletData => _myWalletData;
  MyWalletDetails? get getSelectedHomeWallet => _selectedHomeWallet;
  List<CoinMarketResponse> get getFavoriteCoinMarketData {
    fetchFavoriteCoins();
    return _favoriteCoinMarketData;
  }

  //Methods
  void setCoinMarketData(List<CoinMarketResponse?>? value) {
    _coinMarketData = value;
    notifyListeners();
  }

  void addToMyWalletData(MyWalletDetails value) {
    _myWalletData.add(value);
    notifyListeners();
  }

  void setMySelectedHomeWallet(MyWalletDetails value) {
    _selectedHomeWallet = value;
    notifyListeners();
  }

  void addToFavouriteWalletData(CoinMarketResponse value) {
    _favoriteCoinMarketData.add(value);

    saveFavoriteCoins(_favoriteCoinMarketData);
    notifyListeners();
  }

  void removeWallet(int index) {
    _myWalletData.removeAt(index);

    if (_myWalletData.isEmpty) {
      _selectedHomeWallet == null;
      notifyListeners();
    } else {
      _selectedHomeWallet = _myWalletData.first;
      notifyListeners();
    }
    notifyListeners();
    notifyListeners();
  }

  Future<void> fetchFavoriteCoins() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? coinJsonList = prefs.getStringList("favoriteCoinMarketData");

    // Decode and assign to _favoriteCoinMarketData if data exists
    if (coinJsonList != null) {
      _favoriteCoinMarketData = coinJsonList
          .map((coinJson) => CoinMarketResponse.fromJson(json.decode(coinJson)))
          .toList();
    } else {
      _favoriteCoinMarketData = [];
    }

    // Notify listeners to update UI
    notifyListeners();
  }

  Future<void> saveFavoriteCoins(List<CoinMarketResponse> favoriteCoins) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> coinJsonList =
        favoriteCoins.map((coin) => json.encode(coin.toJson())).toList();
    await prefs.setStringList("favoriteCoinMarketData", coinJsonList);
    _favoriteCoinMarketData = favoriteCoins;
    notifyListeners();
  }
}
