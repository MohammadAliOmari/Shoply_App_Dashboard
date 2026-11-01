import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shoply_app_dashboard/core/model/order/response_order.dart';
import 'package:shoply_app_dashboard/core/router/app_pages.dart';
import 'package:shoply_app_dashboard/core/utils/theme/app_colors.dart';
import 'package:shoply_app_dashboard/core/utils/widgets/custom_cashed_image.dart';
import 'package:shoply_app_dashboard/core/utils/widgets/custom_refresh_indicator.dart';
import 'package:shoply_app_dashboard/features/order/view_model/cubit.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key, required this.status, required this.orderList});

  final List<OrderResponse> orderList;
  final String status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomRefreshIndicator(
      onRefresh: () async {
        await context.read<OrderCubit>().refreshOrders();
      },
      child: ListView.separated(
        itemBuilder: (context, index) {
          Color statusBgColor;
          Color statusTextColor;
          Color statusBorderColor;
          String statusOrder = orderList[index].status!;

          if (statusOrder == 'pending') {
            statusBgColor = Colors.orange.shade100;
            statusTextColor = Colors.orange;
            statusBorderColor = Colors.orange;
          } else if (statusOrder == 'shipped') {
            statusBgColor = Colors.blue.shade100;
            statusTextColor = Colors.blue;
            statusBorderColor = Colors.blue;
          } else if (statusOrder == 'delivered') {
            statusBgColor = Colors.green.shade100;
            statusTextColor = AppColors.primaryColor;
            statusBorderColor = AppColors.primaryColor;
          } else {
            statusBgColor = Colors.grey.shade100;
            statusTextColor = Colors.grey;
            statusBorderColor = Colors.grey;
          }

          if ((orderList[index].status != status) && status != 'all') {
            return SizedBox.shrink();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: theme.dividerColor, width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 90,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: theme.cardColor,
                            ),
                            child: CustomCachedImageNetwork(
                              image: orderList[index].cart![0].images![0],
                              height: 100,
                              width: 90,
                            ),
                          ),
                          if (orderList[index].cart!.length > 1)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: theme.primaryColor,
                                child: Text(
                                  '${orderList[index].cart!.length - 1}+',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.surface,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            'Order #${orderList[index].id!.substring(0, 5)} ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${orderList[index].cart!.length} items',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '\$${orderList[index].subTotal!.toStringAsFixed(2)} ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: statusBgColor,
                          border: Border.all(
                            color: statusBorderColor,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          orderList[index].status ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: statusTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(width: 2, color: theme.primaryColor),
                    ),
                    onPressed: () async {
                      await Navigator.pushNamed(
                        context,
                        AppPages.orderDetailsScreen,
                        arguments: {'order': orderList[index]},
                      );
                      if (context.mounted) {
                        context.read<OrderCubit>().refreshOrders();
                      }
                    },
                    child: Text(
                      'View Order Details',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 5);
        },
        itemCount: orderList.length,
      ),
    );
  }
}
