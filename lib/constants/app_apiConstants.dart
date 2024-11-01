// ignore_for_file: file_names

enum RequestMethods { get, post, put, delete, patch }

class AppApiConstants {
  static const fetchCoinMarketUrl =
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=200&page=1&sparkline=true&price_change_percentage=1h';
}
