import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrenciesPage extends StatelessWidget {
  const CurrenciesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Column(
          children: [
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

            Text(
              'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است چاپگرها و متون بلکه روزنامه و مجله در ستون و تکنولوژی مورد نیاز',
              style: Theme.of(context).textTheme.bodySmall,
            ),

            SizedBox(height: 20),

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
                itemCount: 16,
                itemBuilder: (BuildContext context, int position) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0,16,0,0),
                    child: CurrencyListItem(),
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
  const CurrencyListItem({
    super.key,
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
            'دلار',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            '109.856 تومان',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            '6.2%',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}