import 'package:arzin/models/currency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CurrenciesPage extends StatefulWidget {
  const CurrenciesPage({super.key});

  @override
  State<CurrenciesPage> createState() => _CurrenciesPageState();
}

class _CurrenciesPageState extends State<CurrenciesPage> {
  List<Currency> currencies = [];

  final String apiKey = dotenv.env['API_KEY']!;

  final String apiUrl = dotenv.env['BASE_URL']!;

  String get apiMain => '$apiUrl?key=$apiKey';

  dynamic getResponse(){

    var url = apiMain;
    http.get(
      Uri.parse(url),
    ).then(
      (value){
        
        if (currencies.isEmpty) {
          if (value.statusCode == 200) { // If request is ok :
          
            final jsonMap = convert.jsonDecode(value.body) as Map<String, dynamic> ;
            final currencyList = jsonMap['currency'] as List;

            if (currencyList.isNotEmpty) { // if currency list have objects :
              
              for (var item in currencyList) {

                setState(() {
                  currencies.add(
                    Currency(
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

      }
    );

  }

  @override
  Widget build(BuildContext context) {

    getResponse();

    return SafeArea(
      child: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Column(
          children: [
            // Icon Title
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Color(0xffFEBA17),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Icon(
                    CupertinoIcons.question,
                    color: Colors.white,
                  ),
                ),

                SizedBox(width: 8),
                
                Text(
                  'نرخ ارز آزاد چیست؟',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),

            SizedBox(height: 10),

            // TextArea
            Text(
              'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است چاپگرها و متون بلکه روزنامه و مجله در ستون و تکنولوژی مورد نیاز',
              style: Theme.of(context).textTheme.bodySmall,
            ),

            SizedBox(height: 20),
            
            // Table Header
            Container(
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
            ),

            // List
            SizedBox(
              width: double.infinity,
              height: 280,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: currencies.length,
                itemBuilder: (BuildContext context, int position) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0,16,0,0),
                    child: CurrencyListItem(
                      position: position,
                      list: currencies,
                    ),
                  );
                },
              ),
            ),

            // Button Box
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 24),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffe2e2e2).withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Update Button
                    TextButton.icon(
                      onPressed: () => _showSnackBar(context, 'با موفقیت بروز شد'), 
                      style: ButtonStyle(
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
                      'آخرین بروزرسانی ' '${_getSystemTime()}',
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
}

// Get System Time
String _getSystemTime() {

  return '20:45';

}

// Success Snackbar
void _showSnackBar(BuildContext context, String msg) {

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8)
      ),
      elevation: 0,
      duration: const Duration(seconds: 4),
      backgroundColor: Colors.green,
      content: Text(
        msg,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    ),
  );

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
            list[position].nameFa!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            '${list[position].price} ${list[position].priceUnit} ',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            '${list[position].changePercent!}%',
            style: TextStyle(
              color: list[position].changePercent!.startsWith('-') ? Colors.red : Colors.green,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}