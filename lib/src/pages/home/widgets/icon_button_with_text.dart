import 'package:flutter/material.dart';

class IconButtonWithText extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  IconButtonWithText({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
