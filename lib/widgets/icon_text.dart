import 'package:flutter/material.dart';

/// A small icon followed by a line of text.
class IconText extends StatelessWidget {
  const IconText({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor = Colors.grey,
    this.bold = false,
  });

  final IconData icon;
  final String text;
  final Color iconColor;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
            color: bold ? null : Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
