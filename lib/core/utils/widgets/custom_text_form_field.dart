import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.validator,
    required this.hinText,
    this.prefixIcon,
    this.obscureText,
    this.maxLines,
  });
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hinText;
  final Widget? prefixIcon;
  final bool? obscureText;
  final int? maxLines;

  @override
  State<CustomTextFormField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<CustomTextFormField> {
  bool? isHide;

  @override
  void initState() {
    isHide = widget.obscureText;
    super.initState();
  }

  void changeIsHide() {
    isHide = !(isHide ?? false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      maxLines: widget.maxLines ?? 1,
      obscureText: isHide ?? false,
      controller: widget.controller,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      textInputAction: TextInputAction.next,
      validator: widget.validator,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        helperText: '',
        helperStyle: TextStyle(fontSize: 12),
        hintText: widget.hinText,
        hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        suffixIcon: widget.obscureText == true
            ? GestureDetector(
                onTap: () {
                  changeIsHide();
                },
                child: isHide ?? false
                    ? Icon(
                        Icons.visibility_off_outlined,
                        size: 28,
                        color: Colors.grey.shade800,
                      )
                    : Icon(
                        Icons.visibility_outlined,
                        size: 28,
                        color: Colors.grey.shade800,
                      ),
              )
            : null,
        contentPadding: EdgeInsets.symmetric(vertical: 17, horizontal: 10),
        prefixIcon: widget.prefixIcon,
        fillColor: theme.cardColor,
        filled: true,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
