import 'package:flutter/material.dart';

class AppBarArzin extends StatelessWidget implements PreferredSizeWidget {
  
  @override
  final Size preferredSize;

  const AppBarArzin({super.key})
    : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      actions: [
        const SizedBox(width: 16), // Space from Left
    
        Image.asset('assets/img/logo-icon.png'),
    
        const SizedBox(width: 8),
    
        Align(
          alignment: AlignmentGeometry.centerRight,
          child: const Text(
            'نرخ بروز ارز با ارزین',
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
    );
  }
}