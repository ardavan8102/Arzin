import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        actions: [
          const SizedBox(width: 16), // Space from Left

          Image.asset('assets/img/icon-appbar.png'),

          const SizedBox(width: 6),

          Align(
            alignment: AlignmentGeometry.centerRight,
            child: const Text(
              'قیمت بروز نرخ ارز',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          Expanded(
            child: Align(
              alignment: AlignmentGeometry.centerLeft,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.menu),
              ),
            ),
          ),

          const SizedBox(width: 16), // Space from Right
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.amberAccent.withValues(alpha: 0.3),
                  ),
                  child: Icon(
                    Icons.question_mark,
                    color: Colors.amberAccent,
                  ),
                ),

                SizedBox(width: 8),
        
                Text(
                  'نرخ ارز آزاد چیست؟',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            Text(
              'نرخ ارزها در معاملات نقدی و رایج روازانه است معاملات نقدی معاملاتی هستند که خریدار و فروشنده به محض انجام معامله ارز و ریال را باهم تبادل میکنند',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }
}