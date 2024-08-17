// model.dart

import 'dart:convert';

class CurrencyRate {
  final String result;
  final String baseCode;
  final Map<String, double> rates;
  final String timeLastUpdateUtc;
  final String timeNextUpdateUtc;

  CurrencyRate({
    required this.result,
    required this.baseCode,
    required this.rates,
    required this.timeLastUpdateUtc,
    required this.timeNextUpdateUtc,
  });

  factory CurrencyRate.fromJson(Map<String, dynamic> json) {
    return CurrencyRate(
      result: json['result'],
      baseCode: json['base_code'],
      rates: Map<String, double>.from(
        json['conversion_rates'].map((key, value) => MapEntry(key, value.toDouble())),
      ),
      timeLastUpdateUtc: json['time_last_update_utc'],
      timeNextUpdateUtc: json['time_next_update_utc'],
    );
  }
}

// To convert from JSON string to CurrencyRate object
CurrencyRate parseCurrencyRate(String responseBody) {
  final jsonData = jsonDecode(responseBody);
  return CurrencyRate.fromJson(jsonData);
}
