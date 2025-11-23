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
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const SizedBox(width: 10), // Space from right
          
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
      
          const SizedBox(width: 4), // Space from left
        ],
      ),
    );
    
  }
}

