
import 'package:flutter/material.dart';
import 'model.dart';
import 'dart:convert';
import 'splash.dart';
import 'main2.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:country_icons/country_icons.dart';
import 'package:flutter_flow_chart/flutter_flow_chart.dart';
import 'model2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false, // Disable the debug banner

      home:  SplashScreen(),
    );
  }
}


class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  CurrencyRate? _currencyRate;
  bool _isLoading = false;
  String? _errorMessage;
  String _selectedCurrency = "USD";
  String _selectedCurrency2 = "USD";

  double _inputAmount = 1.0;
  String _result = "";
  final TextEditingController _controller = TextEditingController();


  @override
  void initState() {
    super.initState();
    fetchCurrencyData();
  }

  Future<void> fetchCurrencyData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http.get(
        Uri.parse("https://v6.exchangerate-api.com/v6/latest/USD"),
        headers: {
          "Authorization": "Bearer 1adf6b1a026501ccae5fc09e",
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          _currencyRate = CurrencyRate.fromJson(json);
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = "Failed to load data";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "An error occurred: $e";
        _isLoading = false;
      });
    }
  }




  void _convertCurrency() {
    if (_currencyRate == null) return;

    final rate = _currencyRate!.rates[_selectedCurrency];
    final rate2 = _currencyRate!.rates[_selectedCurrency2];

    if (rate != null && rate2 != null) {
      setState(() {
        _result = (_inputAmount * (rate2 / rate)).toStringAsFixed(2);
      });
    }
  }

  Map<String, String> currencyToCountryCode = {
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


  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body:  SingleChildScrollView(
        child: Column(
            children: [
        

              Stack(
                    clipBehavior: Clip.none,
                  children: [
        
                    Container(
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50.0,left: 10,right: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Currency Converter",style: TextStyle(color:Colors.white,fontSize: 26,fontWeight: FontWeight.bold,fontFamily: "Schyler",),),
                          CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.menu)),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(30, 20),
                        bottomRight: Radius.elliptical(30, 20),
                      ),
                    ),
                  ),
        
                    Positioned(
                      bottom: -50,
                      left: 20,
                      right: 20,
                      child: Card(
                        elevation: 8, // Shadow effect
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          child: Column(
                            children: [
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                DropdownButton<String>(
        
                                  value: _selectedCurrency,
                                  style: (TextStyle(fontFamily: "Schyler",color: Colors.black)),
                                  borderRadius: BorderRadius.circular(30),
        
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedCurrency = newValue!;
                                    });
                                  },
                                  items: _currencyRate?.rates.keys.map<
                                      DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
        
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'icons/flags/svg/${currencyToCountryCode[value]}.svg',
                                            width: 24,
                                            height: 24,
                                            package: 'country_icons',
                                          ),
                                          const SizedBox(width: 8),
                                          Text(value),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                                Icon(Icons.currency_exchange_rounded),
                                DropdownButton<String>(
                                  value: _selectedCurrency2,
                                  style: (TextStyle(fontFamily: "Schyler",color: Colors.black)),
        
                                  borderRadius: BorderRadius.circular(30),
        
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedCurrency2 = value!;
                                    });
                                  },
                                  items: _currencyRate?.rates.keys.map<DropdownMenuItem<String>>((
                                      String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'icons/flags/svg/${currencyToCountryCode[value]}.svg',
                                            width: 24,
                                            height: 24,
                                            package: 'country_icons',
                                          ),
                                          const SizedBox(width: 8),
                                          Text(value),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                              SizedBox(height: 20,),
                              SizedBox(
                                width: 200,
                                height: 50,
                                child: TextField(
        
                                  controller: _controller,
                                  style: (TextStyle(fontFamily: "Schyler",color: Colors.black)),
        
                                  decoration: InputDecoration(
                                      labelText: 'Amount',
        
                                      border: OutlineInputBorder(
        
                                        borderRadius: BorderRadius.circular(30),
        
                                      )
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      _inputAmount = double.tryParse(value) ?? 0.0;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(height: 10,),
                          ElevatedButton(
        
                            onPressed: _convertCurrency,
                            child: const Text('Convert',style: TextStyle(color: Colors.white,fontFamily: "Schyler",fontWeight: FontWeight.bold),),
                            style: ElevatedButton.styleFrom(
                                elevation: 5,
                                backgroundColor: Colors.blueAccent
        
                        ),
                          ),
        
        
        
                            ],
        
                          ),
                        ),
                      ),
                    ),
        
        
        
        
        
                        ]
                ),
        
              SizedBox(height: 50,),
        
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _errorMessage != null
                    ? Center(child: Text(_errorMessage!))
                    : Column(
                  children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [

        
                       ],
                     ),
                    const SizedBox(height: 20),
        
        
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'icons/flags/svg/${currencyToCountryCode[_selectedCurrency2]}.svg',
                          width: 24,
                          height: 24,
                          package: 'country_icons',
                        ),
                        SizedBox(width: 8),
                        Text(
                          '$_result $_selectedCurrency2',
                          style: const TextStyle(fontSize: 24,fontFamily: "Schyler"),
        
                        ),
                      ],
                    ),
                      Container(
                        height: 330,
                        child: CurrencyExchangeScreen(),
                      )
                    ],
        
                ),
              ),
            ],
          ),
      ),
      
        bottomNavigationBar: Container(

          height: 60.0,

          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.blueAccent,


            borderRadius: BorderRadius.circular(30.0),

          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,

            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.currency_exchange_outlined),
                label: 'Rates',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            onTap: _onItemTapped,

          ),
        )

    );

  }
}



class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Home Screen',
        style: TextStyle(fontSize: 24,fontFamily: "Schyler"),
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Favorites Screen',
        style: TextStyle(fontSize: 24,fontFamily: "Schyler"),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile Screen',
        style: TextStyle(fontSize: 24,fontFamily: "Schyler"),
      ),
    );
  }
}





