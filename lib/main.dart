import 'package:arzin/ui/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dotenv.load(fileName: 'assets/.env').then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arzin',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('fa', 'IR'), // Persian
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Dana',
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            fontFamily: 'Dana',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),

          headlineLarge: TextStyle(
            fontFamily: 'Dana',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),

          headlineSmall: TextStyle(
            fontFamily: 'Dana',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),

          bodySmall: TextStyle(
            fontFamily: 'Dana',
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: Colors.black.withValues(alpha: 0.6),
            height: 1.5,
          ),

          bodyMedium: TextStyle(
            fontFamily: 'Dana',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}