import 'package:flutter/material.dart';
import 'package:shoply_app_dashboard/core/utils/widgets/custom_shimmer_loading.dart';

class OrdersShimmerList extends StatelessWidget {
  const OrdersShimmerList({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: ListView.separated(
        itemCount: itemCount,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) => const _OrderShimmerCard(),
      ),
    );
  }
}

class _OrderShimmerCard extends StatelessWidget {
  const _OrderShimmerCard();

  Widget _box({double? width, required double height, double radius = 8}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          _box(width: 80, height: 80, radius: 12), // image
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _box(width: 140, height: 16), // order id / name
                SizedBox(height: 5),
                _box(width: 140, height: 16), // order id / name
                const SizedBox(height: 8),
                _box(width: 90, height: 14), // date / items
                const SizedBox(height: 30),
                Center(
                  child: _box(width: 120, height: 40, radius: 20),
                ), // status chip
              ],
            ),
          ),
          const SizedBox(width: 12),
          _box(width: 60, height: 20), // total price
        ],
      ),
    );
  }
}
