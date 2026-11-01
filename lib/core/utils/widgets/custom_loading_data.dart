import 'package:flutter/material.dart';

class CustomLoadingData extends StatelessWidget {
  const CustomLoadingData({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(child: CircularProgressIndicator(color: theme.primaryColor));
  }
}
