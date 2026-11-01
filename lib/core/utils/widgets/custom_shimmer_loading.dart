import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Opacity(
      opacity: 0.2,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[500]!,
        highlightColor: theme.cardColor,
        enabled: true,
        child: child,
      ),
    );
  }
}
