import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': CupertinoIcons.house_fill, 'label': 'صفحه اصلی'},
      {'icon': CupertinoIcons.money_dollar, 'label': 'ارز آزاد'},
      {'icon': CupertinoIcons.bitcoin, 'label': 'ارز دیجیتال'},
      {'icon': CupertinoIcons.info, 'label': 'درباره ما'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F0F),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(items.length, (i) {
          final selected = currentIndex == i;
          return GestureDetector(
            onTap: () => onTap(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xffFEBA17).withValues(alpha: 0.2)
                    : const Color(0xFF1C1C1C),
                borderRadius: BorderRadius.circular(6),
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: const Color(0xFFFEBA17).withValues(alpha: 0.4),
                          blurRadius: 18,
                          spreadRadius: 1,
                        ),
                      ]
                    : [],
              ),
              child: Row(
                children: [
                  Icon(
                    items[i]['icon'] as IconData,
                    color: selected ? Color(0xffFEBA17) : Colors.grey[400],
                  ),
                  if (selected) ...[
                    const SizedBox(width: 6),
                    Text(
                      items[i]['label'] as String,
                      style: const TextStyle(
                        color: Color(0xffFEBA17),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
