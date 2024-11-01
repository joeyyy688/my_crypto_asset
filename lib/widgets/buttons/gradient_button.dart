import 'package:flutter/material.dart';

class GradientIconButton extends StatelessWidget {
  final Widget icon;

  final List<Color> gradientColors;
  const GradientIconButton(
      {super.key, required this.icon, required this.gradientColors});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 1.0],
            colors: gradientColors,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: icon);
  }
}
