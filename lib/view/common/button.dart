import "package:flutter/material.dart";

class CCElevatedButtonWithIcon extends StatelessWidget {
  const CCElevatedButtonWithIcon({
    super.key,
    required this.iconData,
    required this.buttonText,
    required this.onPressed,
  });

  final Function() onPressed;
  final IconData iconData;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromWidth(160),
      ),
      icon: Icon(
        iconData,
        size: 18,
      ),
      label: Text(
        buttonText,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          letterSpacing: 1,
          fontSize: 12,
        ),
      ),
    );
  }
}
