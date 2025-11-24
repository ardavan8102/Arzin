import 'dart:convert' as convert;
import 'package:arzin/models/currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'dart:ui' as dart_ui;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Persian Date
  List<String> getPersianDate() {
    final now = DateTime.now();
    final jalali = Jalali.fromDateTime(now);
    final formatter = jalali.formatter;

    // Day Names
    final List<String> weekDays = [
      'شنبه',
      'یک‌شنبه',
      'دوشنبه',
      'سه‌شنبه',
      'چهارشنبه',
      'پنج‌شنبه',
      'جمعه',
    ];

    final weekdayName = weekDays[jalali.weekDay - 1];
    String weekDay = weekdayName;
    String date = '${formatter.d} ${formatter.mN} ${formatter.yyyy}';
    List<String> result = [weekDay, date];
    return result;
  }

  List<Currency> currencies = [];
  

  final String apiKey = dotenv.env['API_KEY']!;

  final String apiUrl = dotenv.env['BASE_URL']!;

  String get apiMain => '$apiUrl?key=$apiKey';

  // get api response
  Future getResponse(BuildContext context) async {

    var url = apiMain;
    var value = await http.get(Uri.parse(url));

    if (currencies.isEmpty) {
      if (value.statusCode == 200) { // If request is ok :
      
        final jsonMap = convert.jsonDecode(value.body) as Map<String, dynamic> ;
        final currencyList = jsonMap['currency'] as List;

        if (currencyList.isNotEmpty) {
          final items = currencyList.map((item) {
            return Currency(
              symbol: item['symbol'] ?? '',
              nameEn: item['name_en'] ?? '',
              nameFa: item['name'] ?? '',
              date: item['date'] ?? '',
              time: item['time'] ?? '',
              price: item['price']?.toString() ?? '',
              priceUnit: item['unit'] ?? '',
              changePercent: item['change_percent']?.toString() ?? '',
            );
          }).toList();

          setState(() {
            currencies = items;
          });
        }

      }
    }

    return value;

  }

  // Get Currency With Symbol
  Currency getCurrency(String symbol) {
    return currencies.firstWhere(
      (c) => c.symbol.toUpperCase() == symbol.toUpperCase(),
      orElse: () => Currency.empty(),
    );
  }


  @override
  void initState() {
    super.initState();
    getResponse(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Date Show
            showDateBox(),

            SizedBox(height: 20),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.attach_money),
                Text(
                  'ارزهای محبوب',
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.start,
                ),
              ],
            ),

            SizedBox(height: 20),

            // Currency Boxes : Row
            currencies.isEmpty
            ? const CircularProgressIndicator()
            : Column(
              spacing: 16,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildCurrencyBox('USD', Icons.attach_money, 'دلار', Colors.green),
                    SizedBox(width: 12),
                    buildCurrencyBox('EUR', Icons.attach_money, 'یورو', Colors.green),

                  ],
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildCurrencyBox('AED', Icons.attach_money, 'درهم', Colors.green),
                    SizedBox(width: 12),
                    buildCurrencyBox('JPY', Icons.attach_money, 'ین ژاپن', Colors.green),

                  ],
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildCurrencyBox('TRY', Icons.attach_money, 'درهم', Colors.green),
                    SizedBox(width: 12),
                    buildCurrencyBox('GBP', Icons.attach_money, 'ین ژاپن', Colors.green),

                  ],
                ),
              ],
            ),
          
            SizedBox(height: 24),

            // Slider Boxes
            currencies.isEmpty
            ? const CircularProgressIndicator()
            : SizedBox(
                height: MediaQuery.of(context).size.height / 6,
                width: double.infinity,
                child: PageView.builder(
                  controller: PageController(viewportFraction: 1),
                  itemCount: currencies.length,
                  itemBuilder: (context, index) {
                    final reveresedList = currencies.reversed.toList();
                    final currency = reveresedList[index];
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: buildCurrencySlide(currency),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Currency Box
  Widget buildCurrencyBox(String symbol, IconData icon, String nameFa, Color color) {
    final currency = getCurrency(symbol);
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF5F5F5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: const Color(0xffe2e2e2)),
      ),
      padding: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width / 2.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 4),
              Text(nameFa),
            ],
          ),
          SizedBox(height: 6),
          Text(
            currency.price.isNotEmpty 
              ? '${NumberFormat('#,###').format(int.parse(currency.price))} ${currency.priceUnit}'
              : 'در حال بارگذاری...',
          ),
        ],
      ),
    );
  }

  // Date Show
  Container showDateBox() {
    return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: BoxDecoration(
              color: Color(0xffFEBA17).withValues(alpha: 0.15),
              border: Border.all(
                width: 1,
                color: Color(0xffFEBA17),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'امروز',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                
                    SizedBox(width: 5),
                
                    Text(
                      getPersianDate()[0],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffCB9512),
                      ),
                    ),
                
                    SizedBox(width: 5),
                
                    Text(
                      getPersianDate()[1],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }

  // Slider
  Widget buildCurrencySlide(Currency currency) {
    return Directionality(
      textDirection: dart_ui.TextDirection.rtl,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.amber.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.amber.withValues(alpha: 0.5)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currency.nameFa,
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      currency.nameEn.toUpperCase(),
                      style: TextStyle(
                        color: Colors.grey.withValues(alpha: 0.6),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      currency.price.isNotEmpty
                          ? '${NumberFormat('#,###').format(int.parse(currency.price))} ${currency.priceUnit}'
                          : '...',
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: double.tryParse(currency.changePercent) != null &&
                                  double.parse(currency.changePercent) > 0
                              ? Colors.greenAccent
                              : Colors.redAccent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "${currency.changePercent}%",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


}