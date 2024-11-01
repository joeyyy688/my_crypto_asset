import 'package:flutter/material.dart';
import 'package:my_crypto_asset/widgets/buttons/base_button.dart';

class AccentButton extends StatelessWidget {
  const AccentButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.color = const Color(0XFFFF9900),
    this.disabled = false,
  });

  final VoidCallback? onPressed;
  final bool disabled;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      onPressed: onPressed,
      label: label,
      backgroundColor:
          disabled ? const Color(0xFF030412).withOpacity(0.2) : color,
      labelColor: Colors.white,
    );
  }
}
