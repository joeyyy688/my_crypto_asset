import 'package:flutter/material.dart';
import 'package:my_crypto_asset/widgets/buttons/base_button.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.color = Colors.black,
    this.disabled = false,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final bool disabled;
  final String label;
  final Color color;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      isLoading: isLoading,
      onPressed: onPressed,
      label: label,
      backgroundColor: disabled ? const Color(0xFFE3E6EA) : color,
      labelColor: Colors.white,
    );
  }
}
