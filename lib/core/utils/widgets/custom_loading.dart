import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  static void showDialogLoading({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: theme.primaryColor),
              SizedBox(height: 15),
              Text(
                'Please wait...',
                style: TextStyle(
                  color: theme.primaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
