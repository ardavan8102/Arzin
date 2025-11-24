import 'package:arzin/models/currency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:intl/intl.dart';

class CryptoPage extends StatefulWidget {
  const CryptoPage({super.key});

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
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
        final currencyList = jsonMap['cryptocurrency'] as List;

        if (currencyList.isNotEmpty) { // if currency list have objects :
          
          for (var item in currencyList) {

            setState(() {
              currencies.add(
                Currency(
                  symbol: item['symbol'] ?? '',
                  nameEn: item['name_en'] ?? '',
                  nameFa: item['name'] ?? '',
                  date: item['date'] ?? '',
                  time: item['time'] ?? '',
                  price: item['price']?.toString() ?? '',
                  priceUnit: item['unit'] ?? '',
                  changePercent: item['change_percent']?.toString() ?? '',
                ),
              );
            });
          }

        }

      }
    }

    return value;

  }

  String currentTime = "--:--";

  // Get Device Time clock
  void getDeviceTime() {
    final now = DateTime.now(); // گرفتن زمان فعلی دستگاه
    final formattedTime = DateFormat('HH:mm').format(now); // فرمت کردن به ساعت:دقیقه
    setState(() {
      currentTime = formattedTime;
    });
  }

  @override
  void initState() {
    super.initState();
    getResponse(context);
    getDeviceTime();
  }

  @override
  void didUpdateWidget(covariant CryptoPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Column(
          children: [
            
            // Table Header
            tableHeader(context),

            // List
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              child: listFutureBuilder(context),
            ),

            // Button Box
            SizedBox(
              height: MediaQuery.of(context).size.height / 7,
              child: Container(
                margin: EdgeInsets.only(top: 24),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffe2e2e2).withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 24,
                  children: [
                    // Update Button
                    TextButton.icon(
                      onPressed: () {

                        currencies.clear();

                        listFutureBuilder(context);

                        showSuccessSnack(context, 'بروزرسانی با موفقیت انجام شد ✅');

                      }, 
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all(EdgeInsets.all(16)),
                        backgroundColor: WidgetStateProperty.all(Color(0xffFEBA17)),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(6),
                          ),
                        ),
                      ),
                      label: Text(
                        'بروزرســـانی',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      icon: Icon(
                        CupertinoIcons.refresh_bold,
                        color: Colors.white,
                      ),
                    ),

                    Text(
                      'آخرین بروزرسانی ' '$currentTime',
                    ),

                    SizedBox(width: 0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Table Header
  Container tableHeader(BuildContext context) {
    return Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade700,
              borderRadius: BorderRadius.circular(6)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'نام ارز',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),

                Text(
                  'قیمت',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),

                Text(
                  'تغییر',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                
              ],
            ),
          );
  }

  // List View Builder With Future
  FutureBuilder<dynamic> listFutureBuilder(BuildContext context) {
    return FutureBuilder(
              future: getResponse(context),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.amber),
                  );
                } else if (asyncSnapshot.hasError) {
                  return Center(
                    child: Text('خطا در دریافت داده', style: TextStyle(color: Colors.red)),
                  );
                } else if (currencies.isEmpty) {
                  return Center(
                    child: Text('هیچ داده‌ای یافت نشد'),
                  );
                } else {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: currencies.length,
                    itemBuilder: (BuildContext context, int position) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: CurrencyListItem(
                          position: position,
                          list: currencies,
                        ),
                      );
                    },
                  );
                }
              },
            );
  }
}

// Show SnackBar
void showSuccessSnack(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
    backgroundColor: Colors.green.shade600,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    duration: const Duration(seconds: 3),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

// Item for Price listview
class CurrencyListItem extends StatelessWidget {
  final int position;
  final List<Currency> list;

  const CurrencyListItem({
    super.key,
    required this.position,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.fromLTRB(10,12,10,12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffe2e2e2).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            list[position].nameFa,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            '${NumberFormat('#,###').format(double.parse(list[position].price))} ${list[position].priceUnit}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            '${list[position].changePercent}%',
            style: TextStyle(
              color: list[position].changePercent.startsWith('-') ? Colors.red : Colors.green,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}