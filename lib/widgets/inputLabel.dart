// ignore_for_file: file_names

import 'package:flutter/material.dart';

class InputLabel extends StatelessWidget {
  final String label;
  final TextStyle? labelStyle;
  const InputLabel({super.key, required this.label, this.labelStyle});

  @override
  Widget build(BuildContext context) {
    return Text(label, style: labelStyle);
  }
}
