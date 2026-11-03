import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// The mediGO app mark: a teal rounded square with a heart.
class LogoMark extends StatelessWidget {
  const LogoMark({super.key, this.size = 80});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(size * 0.2),
      ),
      child: Icon(Icons.favorite, color: Colors.white, size: size * 0.5),
    );
  }
}
