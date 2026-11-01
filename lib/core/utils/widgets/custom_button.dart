import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonText,
    this.style,
    this.onPressed,
    this.height,
    this.width,
    this.radius,
    this.fontSize,
  });
  final String buttonText;
  final TextStyle? style;
  final void Function()? onPressed;
  final double? height;
  final double? width;
  final double? radius;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: height ?? 62,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(radius ?? 18),
          ),
          backgroundColor: theme.primaryColor,
        ),
        child: Text(
          buttonText,
          style:
              style ??
              TextStyle(
                fontSize: fontSize ?? 30,
                color: theme.colorScheme.surface,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}
