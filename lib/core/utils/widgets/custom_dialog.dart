import 'package:flutter/material.dart';
import 'package:pro_dialog/pro_dialog.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  static void showCustomDialog({
    required BuildContext context,
    required String title,
    required String description,
    void Function()? onPressed,
    required DialogType type,
    List<DialogButton>? buttons,
  }) {
    showProDialog(
      context,
      type: type,
      theme: ProDialogTheme(
        backgroundColor: Theme.of(context).cardColor,
        titleStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
        descriptionStyle: TextStyle(
          fontSize: 16,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
      title: title,
      description: description,

      buttons:
          buttons ??
          [
            DialogButton(
              text: 'Got it',
              onPressed: onPressed ?? () {},
              isPrimary: true,
            ),
          ],
    );
  }
}
