import 'package:arzin/Ui/home.dart';
import 'package:arzin/components/appbar.dart';
import 'package:arzin/components/bottom_nav.dart';
import 'package:arzin/ui/aboutus.dart';
import 'package:arzin/ui/currencies.dart';
import 'package:arzin/ui/settings.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final pages = [
    const HomePage(),
    const CurrenciesPage(),
    const SettingsPage(),
    const AboutUsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarArzin(),
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: selectedIndex,
        onTap: (index) => setState(() => selectedIndex = index),
      ),
    );
  }
}

