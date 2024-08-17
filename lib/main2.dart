import 'package:flutter/material.dart';
import 'model.dart';
import 'dart:convert';
import 'splash.dart';
import 'main.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:country_icons/country_icons.dart';
import 'package:flutter_flow_chart/flutter_flow_chart.dart';
import 'model2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';



Future<CurrencyResponse> fetchCurrencyData(String baseCurrency) async {
  final response = await http.get(
    Uri.parse('https://v6.exchangerate-api.com/v6/1adf6b1a026501ccae5fc09e/latest/$baseCurrency'),
  );

  if (response.statusCode == 200) {
    return CurrencyResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load currency data');
  }
}

class CurrencyExchangeScreen extends StatefulWidget {
  @override
  _CurrencyExchangeScreenState createState() => _CurrencyExchangeScreenState();
}

class _CurrencyExchangeScreenState extends State<CurrencyExchangeScreen> {
  String _selectedCurrency = 'PKR';
  double? _usdRate;
  double? _selectedCurrencyRate;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      // Fetch data for USD and selected currency
      final usdData = await fetchCurrencyData('USD');
      final selectedData = await fetchCurrencyData(_selectedCurrency);

      setState(() {
        _usdRate = usdData.conversionRates['USD'];
        _selectedCurrencyRate = selectedData.conversionRates['USD'];
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }


  Map<String, String> currencyToCountryCode2 = {
    "USD": "us",
    "AED": "ae",
    "AFN": "af",
    "ALL": "al",
    "AMD": "am",
    "ANG": "cw", // Curaçao and Sint Maarten
    "AOA": "ao",
    "ARS": "ar",
    "AUD": "au",
    "AWG": "aw",
    "AZN": "az",
    "BAM": "ba",
    "BBD": "bb",
    "BDT": "bd",
    "BGN": "bg",
    "BHD": "bh",
    "BIF": "bi",
    "BMD": "bm",
    "BND": "bn",
    "BOB": "bo",
    "BRL": "br",
    "BSD": "bs",
    "BTN": "bt",
    "BWP": "bw",
    "BYN": "by",
    "BZD": "bz",
    "CAD": "ca",
    "CDF": "cd",
    "CHF": "ch",
    "CLP": "cl",
    "CNY": "cn",
    "COP": "co",
    "CRC": "cr",
    "CUP": "cu",
    "CVE": "cv",
    "CZK": "cz",
    "DJF": "dj",
    "DKK": "dk",
    "DOP": "do",
    "DZD": "dz",
    "EGP": "eg",
    "ERN": "er",
    "ETB": "et",
    "EUR": "eu",
    "FJD": "fj",
    "FKP": "fk",
    "FOK": "fo",
    "GBP": "gb",
    "GEL": "ge",
    "GGP": "gg",
    "GHS": "gh",
    "GIP": "gi",
    "GMD": "gm",
    "GNF": "gn",
    "GTQ": "gt",
    "GYD": "gy",
    "HKD": "hk",
    "HNL": "hn",
    "HRK": "hr",
    "HTG": "ht",
    "HUF": "hu",
    "IDR": "id",
    "ILS": "il",
    "IMP": "im",
    "INR": "in",
    "IQD": "iq",
    "IRR": "ir",
    "ISK": "is",
    "JEP": "je",
    "JMD": "jm",
    "JOD": "jo",
    "JPY": "jp",
    "KES": "ke",
    "KGS": "kg",
    "KHR": "kh",
    "KID": "ki",
    "KMF": "km",
    "KRW": "kr",
    "KWD": "kw",
    "KYD": "ky",
    "KZT": "kz",
    "LAK": "la",
    "LBP": "lb",
    "LKR": "lk",
    "LRD": "lr",
    "LSL": "ls",
    "LYD": "ly",
    "MAD": "ma",
    "MDL": "md",
    "MGA": "mg",
    "MKD": "mk",
    "MMK": "mm",
    "MNT": "mn",
    "MOP": "mo",
    "MRU": "mr",
    "MUR": "mu",
    "MVR": "mv",
    "MWK": "mw",
    "MXN": "mx",
    "MYR": "my",
    "MZN": "mz",
    "NAD": "na",
    "NGN": "ng",
    "NIO": "ni",
    "NOK": "no",
    "NPR": "np",
    "NZD": "nz",
    "OMR": "om",
    "PAB": "pa",
    "PEN": "pe",
    "PGK": "pg",
    "PHP": "ph",
    "PKR": "pk",
    "PLN": "pl",
    "PYG": "py",
    "QAR": "qa",
    "RON": "ro",
    "RSD": "rs",
    "RUB": "ru",
    "RWF": "rw",
    "SAR": "sa",
    "SBD": "sb",
    "SCR": "sc",
    "SDG": "sd",
    "SEK": "se",
    "SGD": "sg",
    "SHP": "sh",
    "SLE": "sl",
    "SLL": "sl",
    "SOS": "so",
    "SRD": "sr",
    "SSP": "ss",
    "STN": "st",
    "SYP": "sy",
    "SZL": "sz",
    "THB": "th",
    "TJS": "tj",
    "TMT": "tm",
    "TND": "tn",
    "TOP": "to",
    "TRY": "tr",
    "TTD": "tt",
    "TVD": "tv",
    "TWD": "tw",
    "TZS": "tz",
    "UAH": "ua",
    "UGX": "ug",
    "UYU": "uy",
    "UZS": "uz",
    "VES": "ve",
    "VND": "vn",
    "VUV": "vu",
    "WST": "ws",
    "XAF": "cm", // Central African Republic
    "XCD": "ag", // Antigua and Barbuda
    "XDR": "xx", // IMF Special Drawing Rights (not a country)
    "XOF": "bj", // Benin (West African CFA franc)
    "XPF": "pf", // French Polynesia
    "YER": "ye",
    "ZAR": "za",
    "ZMW": "zm",
    "ZWL": "zw"
  };
  List<String> getCurrencyList() {
    return currencyToCountryCode2.keys.toList();
  }


  List<DropdownMenuItem<String>> _getDropdownItems() {
    List<String> currencies = getCurrencyList();
    return currencies
        .map((currency) => DropdownMenuItem<String>(
      value: currency,

      child: Row(
        children: [


          // Text("Select any country "),
          SvgPicture.asset(
            'icons/flags/svg/${currencyToCountryCode2[currency]}.svg',
            width: 24,
            height: 24,
            package: 'country_icons',
          ),
          const SizedBox(width: 8), // Space between icon and text
          Text(currency),

        ],
      ),
    ))
        .toList();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(height: 10),

          if (_usdRate != null && _selectedCurrencyRate != null)

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('1 $_selectedCurrency = ${_selectedCurrencyRate?.toStringAsFixed(4)} USD',style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,fontFamily: "Schyler"),
                  textAlign: TextAlign.center,),

                DropdownButton<String>(
                  value: _selectedCurrency,
                  style: (TextStyle(fontFamily: "Schyler",color: Colors.black)),

                  borderRadius: BorderRadius.circular(30),


                  items: _getDropdownItems(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCurrency = value!;
                      _fetchData(); // Fetch new data based on selected currency
                    });
                  },
                ),


              ],
            ),

          SizedBox(height: 20),
          Expanded(
            child: _usdRate != null && _selectedCurrencyRate != null
                ? LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 0.5,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.2),
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.2),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(
                            value == 0 ? 'USD' : _selectedCurrency,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(
                            '${value.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.blueAccent, width: 2),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      if (_usdRate != null) FlSpot(0, _usdRate!),
                      if (_selectedCurrencyRate != null)
                        FlSpot(1, _selectedCurrencyRate!),
                    ],
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: [Colors.blueAccent, Colors.greenAccent],
                    ),
                    barWidth: 6,
                    isStrokeCapRound: true,
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          Colors.blueAccent.withOpacity(0.3),
                          Colors.greenAccent.withOpacity(0.3)
                        ],
                      ),
                    ),
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, bar, index) {
                        return FlDotCirclePainter(
                          radius: 4, // Set the dot size
                          color: Colors.pinkAccent, // Set the dot color
                          strokeWidth: 0,
                          strokeColor: Colors.transparent,
                        );
                      },
                    ),
                  ),
                ],
                minX: 0,
                maxX: 1,
                minY: [
                  if (_usdRate != null) _usdRate!,
                  if (_selectedCurrencyRate != null) _selectedCurrencyRate!,
                ].reduce((a, b) => a < b ? a : b) * 0.9,
                maxY: [
                  if (_usdRate != null) _usdRate!,
                  if (_selectedCurrencyRate != null) _selectedCurrencyRate!,
                ].reduce((a, b) => a > b ? a : b) * 1.1,
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    tooltipPadding: const EdgeInsets.all(8.0),
                    tooltipRoundedRadius: 8,
                    tooltipMargin: 8,
                  ),
                  touchCallback: (FlTouchEvent event, LineTouchResponse? response) {},
                  handleBuiltInTouches: true,
                ),
              ),
            )
                : Center(child: CircularProgressIndicator()),
          ),

        ],
      ),

    );
  }
}
