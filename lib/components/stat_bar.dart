import 'package:flutter/material.dart';

class StatBar extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const StatBar({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: double.tryParse(value) ?? 0,
          width: 20,
          color: color,
        ),
        Text(label),
      ],
    );
  }
}
