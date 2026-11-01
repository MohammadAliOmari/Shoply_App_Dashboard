import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoply_app_dashboard/core/utils/theme/app_colors.dart';
import 'package:shoply_app_dashboard/core/utils/widgets/custom_shimmer_loading.dart';

class CustomCachedImageNetwork extends StatelessWidget {
  const CustomCachedImageNetwork({
    super.key,
    required this.image,
    this.errorWidget,
    this.height,
    this.width,
    this.fit,
  });
  final String image;
  final Widget? errorWidget;
  final double? height;
  final double? width;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height ?? 120,
      width: width ?? 150,
      imageUrl: image,
      fit: fit ?? BoxFit.cover,
      placeholder: (context, url) => ShimmerLoading(
        child: Container(
          height: height ?? 120,
          width: width ?? 150,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      errorWidget: (context, url, error) =>
          errorWidget ??
          Icon(Icons.error_outline, size: 28, color: AppColors.error),
    );
  }
}
