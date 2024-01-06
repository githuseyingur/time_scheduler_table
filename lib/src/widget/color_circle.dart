import 'package:flutter/material.dart';

class ColorCircle extends StatelessWidget {
  const ColorCircle({
    super.key,
    required this.color,
    required this.onTap,
    required this.isSelected,
    required this.size,
  });

  /// color of circle widget.
  final Color color;

  /// method for selecting color circle widgets.
  final Function() onTap;

  /// isSelected indicates whether the color circle widget is selected or not.
  final bool isSelected;

  /// size of color circle widget.
  final double size;

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
          border: Border.all(
              color: isSelected ? Colors.black : Colors.transparent, width: 2),
        ),
      ),
    );
  }
}
