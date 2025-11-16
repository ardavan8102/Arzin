import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 110,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 14),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'سلام اردوان جون',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withValues(alpha: 0.4),
                    ),
                  ),
                  
                  SizedBox(height: 8),

                  Expanded(
                    child: Row(
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
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF5F5F5),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 1,
                      color: Color(0xffe2e2e2),
                    ),
                  ),
                  width: 108,
                  height: 70,
                ),

                SizedBox(width: 20),

                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF5F5F5),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 1,
                      color: Color(0xffe2e2e2),
                    ),
                  ),
                  width: 108,
                  height: 70,
                ),

                SizedBox(width: 20),

                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF5F5F5),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 1,
                      color: Color(0xffe2e2e2),
                    ),
                  ),
                  width: 108,
                  height: 70,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}