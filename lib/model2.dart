class CurrencyResponse {
  final String result;
  final String documentation;
  final String termsOfUse;
  final DateTime timeLastUpdate;
  final DateTime timeNextUpdate;
  final String baseCode;
  final Map<String, double> conversionRates;

  CurrencyResponse({
    required this.result,
    required this.documentation,
    required this.termsOfUse,
    required this.timeLastUpdate,
    required this.timeNextUpdate,
    required this.baseCode,
    required this.conversionRates,
  });

  factory CurrencyResponse.fromJson(Map<String, dynamic> json) {
    return CurrencyResponse(
      result: json['result'],
      documentation: json['documentation'],
      termsOfUse: json['terms_of_use'],
      timeLastUpdate: DateTime.fromMillisecondsSinceEpoch(json['time_last_update_unix'] * 1000),
      timeNextUpdate: DateTime.fromMillisecondsSinceEpoch(json['time_next_update_unix'] * 1000),
      baseCode: json['base_code'],
      conversionRates: Map<String, double>.from(json['conversion_rates'].map(
            (key, value) => MapEntry(key, (value as num).toDouble()),
      )),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'documentation': documentation,
      'terms_of_use': termsOfUse,
      'time_last_update_unix': timeLastUpdate.millisecondsSinceEpoch ~/ 1000,
      'time_next_update_unix': timeNextUpdate.millisecondsSinceEpoch ~/ 1000,
      'base_code': baseCode,
      'conversion_rates': conversionRates,
    };
  }
}
