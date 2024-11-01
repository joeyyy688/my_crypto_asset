// ignore_for_file: file_names

import 'dart:convert';

class CoinMarketResponse {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final num? currentPrice;
  final num? marketCap;
  final num? marketCapRank;
  final num? fullyDilutedValuation;
  final num? totalVolume;
  final num? high24H;
  final num? low24H;
  final num? priceChange24H;
  final num? priceChangePercentage24H;
  final num? marketCapChange24H;
  final num? marketCapChangePercentage24H;
  final num? circulatingSupply;
  final num? totalSupply;
  final num? maxSupply;
  final num? ath;
  final num? athChangePercentage;
  final DateTime athDate;
  final num? atl;
  final num? atlChangePercentage;
  final DateTime atlDate;
  final Roi? roi;
  final DateTime lastUpdated;
  final SparklineIn7D? sparklineIn7D;
  final num? priceChangePercentage1HInCurrency;

  CoinMarketResponse({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    required this.fullyDilutedValuation,
    required this.totalVolume,
    required this.high24H,
    required this.low24H,
    required this.priceChange24H,
    required this.priceChangePercentage24H,
    required this.marketCapChange24H,
    required this.marketCapChangePercentage24H,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.maxSupply,
    required this.ath,
    required this.athChangePercentage,
    required this.athDate,
    required this.atl,
    required this.atlChangePercentage,
    required this.atlDate,
    required this.roi,
    required this.lastUpdated,
    required this.sparklineIn7D,
    required this.priceChangePercentage1HInCurrency,
  });

  factory CoinMarketResponse.fromRawJson(String str) =>
      CoinMarketResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CoinMarketResponse.fromJson(Map<String, dynamic> json) =>
      CoinMarketResponse(
        id: json["id"],
        symbol: json["symbol"],
        name: json["name"],
        image: json["image"],
        currentPrice: json["current_price"],
        marketCap: json["market_cap"],
        marketCapRank: json["market_cap_rank"],
        fullyDilutedValuation: json["fully_diluted_valuation"],
        totalVolume: json["total_volume"],
        high24H: json["high_24h"],
        low24H: json["low_24h"],
        priceChange24H: json["price_change_24h"],
        priceChangePercentage24H: json["price_change_percentage_24h"],
        marketCapChange24H: json["market_cap_change_24h"],
        marketCapChangePercentage24H: json["market_cap_change_percentage_24h"],
        circulatingSupply: json["circulating_supply"],
        totalSupply: json["total_supply"],
        maxSupply: json["max_supply"],
        ath: json["ath"],
        athChangePercentage: json["ath_change_percentage"],
        athDate: DateTime.parse(json["ath_date"]),
        atl: json["atl"],
        atlChangePercentage: json["atl_change_percentage"],
        atlDate: DateTime.parse(json["atl_date"]),
        roi: json["roi"] == null ? null : Roi.fromJson(json["roi"]),
        lastUpdated: DateTime.parse(json["last_updated"]),
        sparklineIn7D: json["sparkline_in_7d"] == null
            ? null
            : SparklineIn7D.fromJson(json["sparkline_in_7d"]),
        priceChangePercentage1HInCurrency:
            json["price_change_percentage_1h_in_currency"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "symbol": symbol,
        "name": name,
        "image": image,
        "current_price": currentPrice,
        "market_cap": marketCap,
        "market_cap_rank": marketCapRank,
        "fully_diluted_valuation": fullyDilutedValuation,
        "total_volume": totalVolume,
        "high_24h": high24H,
        "low_24h": low24H,
        "price_change_24h": priceChange24H,
        "price_change_percentage_24h": priceChangePercentage24H,
        "market_cap_change_24h": marketCapChange24H,
        "market_cap_change_percentage_24h": marketCapChangePercentage24H,
        "circulating_supply": circulatingSupply,
        "total_supply": totalSupply,
        "max_supply": maxSupply,
        "ath": ath,
        "ath_change_percentage": athChangePercentage,
        "ath_date": athDate.toIso8601String(),
        "atl": atl,
        "atl_change_percentage": atlChangePercentage,
        "atl_date": atlDate.toIso8601String(),
        "roi": roi,
        "last_updated": lastUpdated.toIso8601String(),
        "sparkline_in_7d": sparklineIn7D?.toJson(),
        "price_change_percentage_1h_in_currency":
            priceChangePercentage1HInCurrency,
      };
}

class Roi {
  final double times;
  final String currency;
  final double percentage;

  Roi({
    required this.times,
    required this.currency,
    required this.percentage,
  });

  factory Roi.fromRawJson(String str) => Roi.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Roi.fromJson(Map<String, dynamic> json) => Roi(
        times: json["times"],
        currency: json["currency"],
        percentage: json["percentage"],
      );

  Map<String, dynamic> toJson() => {
        "times": times,
        "currency": currency,
        "percentage": percentage,
      };
}

class SparklineIn7D {
  final List<double> price;

  SparklineIn7D({
    required this.price,
  });

  factory SparklineIn7D.fromRawJson(String str) =>
      SparklineIn7D.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SparklineIn7D.fromJson(Map<String, dynamic> json) => SparklineIn7D(
        price: List<double>.from(json["price"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "price": List<dynamic>.from(price.map((x) => x)),
      };
}
