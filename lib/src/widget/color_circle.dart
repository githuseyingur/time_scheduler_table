import 'package:flutter/material.dart';

class ColorCircle extends StatelessWidget {
  ColorCircle({
    super.key,
    required this.color,
    required this.onTap,
    required this.isSelected,
    required this.size,
  });
  Color color;
  Function() onTap;
  bool isSelected;
  double size;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: isSelected ? Colors.black : Colors.transparent, width: 2),
        ),
      ),
    );
  }
}
