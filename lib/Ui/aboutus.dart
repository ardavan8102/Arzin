import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Column(
          children: [
            // Development Target
            textSection(
              context,
              'هدف از ایجاد برنامه',
              'این برنامه یک پروژه متن‌باز (Open Source) هست که داخلش عمدتا با Api کار شده و هدف از ایجادش، یادگیری و در دسترس قرار دادنش برای جامعه برنامه نویسان تازه کار است',
            ),

            SizedBox(height: 40),

            // پیشنهادات و انتقادات
            textSection(
              context,
              'انتقادات و پیشنهادات',
              'هرگونه نظر یا انتقادی در رابطه با عملکرد برنامه داشتید میتونید به ایمیل ardavaneskandari007@gmail.com پیام بدید.',
            ),
          ],
        ),
      ),
    );
  }

  Container textSection(BuildContext context, String title, String text) {
    return Container(
            width: double.infinity,
            padding: EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 3,
                  color: Colors.amber,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: 10),
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          );
  }
}