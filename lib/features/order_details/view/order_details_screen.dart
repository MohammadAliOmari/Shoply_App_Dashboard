import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_dialog/pro_dialog.dart';

import 'package:shoply_app_dashboard/core/model/order/response_order.dart';
import 'package:shoply_app_dashboard/core/utils/widgets/custom_app_bar.dart';
import 'package:shoply_app_dashboard/core/utils/widgets/custom_cashed_image.dart';
import 'package:shoply_app_dashboard/core/utils/widgets/custom_dialog.dart';
import 'package:shoply_app_dashboard/core/utils/widgets/custom_loading.dart';
import 'package:shoply_app_dashboard/features/order_details/view/widgets/order_buttons.dart';
import 'package:shoply_app_dashboard/features/order_details/view_model/cubit.dart';
import 'package:shoply_app_dashboard/features/order_details/view_model/state.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.order});
  final OrderResponse order;
  static const Color primaryGreen = Color(0xFF0A5C43);
  static const Color lightGreen = Color(0xFFD9F5EB);
  static const Color textColor = Color(0xFF10213D);
  static const Color secondaryText = Color(0xFF718096);
  static const Color borderColor = Color(0xFFDDE8EF);
  // static const Color backgroundColor = Color(0xFFF7FAF9);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => OrderDetailsCubit(),
      child: Scaffold(
        body: BlocConsumer<OrderDetailsCubit, OrderDetailsState>(
          listener: (context, state) {
            if (state is OrderDetailsLoadingState) {
              return CustomLoading.showDialogLoading(context: context);
            } else if (state is OrderDetailsErrorState) {
              Navigator.pop(context);
              return CustomDialog.showCustomDialog(
                context: context,
                title: 'Update Status Order ',
                description: 'Update Status Order Field ',
                type: DialogType.error,
              );
            } else if (state is OrderDetailsSucssesState) {
              Navigator.pop(context);
              return CustomDialog.showCustomDialog(
                context: context,
                title: 'Update Status Order ',
                description: 'Update Status Order Success ',
                type: DialogType.success,
                onPressed: () => Navigator.pop(context),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<OrderDetailsCubit>();
            return SafeArea(
              child: Column(
                children: [
                  CustomAppBar(
                    isCenterTitle: false,

                    title: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          'Order details',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '#${order.id?.substring(0, 5)}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    leading: IconButton(
                      onPressed: () {
                        return Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                      child: Column(
                        children: [
                          _buildOrderHeader(theme),
                          const SizedBox(height: 16),
                          _buildOrderTimeline(theme),
                          const SizedBox(height: 16),
                          _buildShippingInformation(theme),
                          const SizedBox(height: 16),
                          _buildOrderItems(theme),
                          const SizedBox(height: 16),
                          _buildOrderSummary(theme),
                          const SizedBox(height: 20),
                          // _buildTrackOrderButton(),
                          const SizedBox(height: 12),
                          OrderStatusButton(
                            status: getOrderStatus(order.status ?? 'pending'),
                            onChanged: (OrderStatus value) {
                              cubit.updateOrderStatus(
                                order: order,
                                status: value.name.toString(),
                              );
                            },
                          ),
                          // _buildContactSupportButton(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Order status summary
  Widget _buildOrderHeader(ThemeData theme) {
    return _card(
      color: theme.cardColor,
      child: Row(
        children: [
          _iconCircle(Icons.inventory_2_outlined, size: 76, iconSize: 38),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: theme.brightness == Brightness.dark
                        ? Colors.black.withValues(alpha: 0.1)
                        : Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 6),
                      Text(
                        (order.status ?? 'pending').toUpperCase(),
                        style: TextStyle(
                          color: theme.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Order #${order.id?.substring(0, 5)}',
                  style: TextStyle(
                    color: theme.primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${order.cart!.length} items',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '\$${order.subTotal!.toStringAsFixed(2)}',
            style: TextStyle(
              color: theme.primaryColor,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  // Order progress timeline
  Widget _buildOrderTimeline(ThemeData theme) {
    final status = (order.status ?? 'pending').toLowerCase().trim();
    final isDelivered = status == 'delivered';
    final isShipped = status == 'shipped' || isDelivered;

    final steps = [
      _OrderStep(
        title: 'Pending',
        completed: isShipped,
        active: status == 'pending',
        icon: isShipped ? Icons.check : Icons.pending,
      ),
      _OrderStep(
        title: 'Shipped',
        completed: isDelivered,
        active: status == 'shipped',
        icon: isDelivered ? Icons.check : Icons.local_shipping_outlined,
      ),
      _OrderStep(
        title: 'Delivered',
        completed: isDelivered,
        active: false,
        icon: isDelivered ? Icons.check : Icons.inventory_2_outlined,
      ),
    ];

    return _card(
      color: theme.cardColor,
      child: Column(
        children: [
          Row(
            children: List.generate(steps.length, (index) {
              final step = steps[index];

              return Expanded(
                child: SizedBox(
                  height: 52,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (index > 0)
                        Positioned(
                          left: 0,
                          right: 25,
                          child: Container(
                            height: 2,
                            color:
                                steps[index - 1].completed &&
                                    (step.completed || step.active)
                                ? primaryGreen
                                : const Color(0xFFD5DDE3),
                          ),
                        ),
                      if (index < steps.length - 1)
                        Positioned(
                          left: 25,
                          right: 0,
                          child: Container(
                            height: 2,
                            color:
                                step.completed &&
                                    (steps[index + 1].completed ||
                                        steps[index + 1].active)
                                ? primaryGreen
                                : const Color(0xFFD5DDE3),
                          ),
                        ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: step.active
                                ? const Color(0xFF07885E)
                                : step.completed
                                ? primaryGreen
                                : const Color(0xFFE9EEF1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            step.icon,
                            color: step.completed
                                ? Colors.white
                                : step.active
                                ? Colors.white
                                : const Color(0xFF7A8795),
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: steps.map((step) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: Column(
                    children: [
                      Text(
                        step.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: step.active
                              ? theme.primaryColor
                              : step.completed
                              ? theme.primaryColor
                              : theme.colorScheme.onSurface,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Shipping information
  Widget _buildShippingInformation(ThemeData theme) {
    return _card(
      color: theme.cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _iconCircle(
                Icons.local_shipping_outlined,
                size: 58,
                iconSize: 30,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shipping Information',
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 14),
                    Text(
                      order.fullName ?? 'No Name',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 12),
                    _InfoRow(
                      textColor: Colors.grey,
                      iconColor: theme.primaryColor,
                      icon: Icons.location_on,
                      text: order.address ?? 'No Address',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // Products
  Widget _buildOrderItems(ThemeData theme) {
    return _card(
      color: theme.cardColor,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Items (${order.cart?.length ?? 0})',
                  style: TextStyle(
                    color: theme.primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              // TextButton.icon(
              //   onPressed: () {},
              //   icon: const Icon(Icons.local_shipping_outlined, size: 20),
              //   label: const Text('Track Package'),
              //   style: TextButton.styleFrom(
              //     foregroundColor: primaryGreen,
              //     padding: const EdgeInsets.symmetric(horizontal: 4),
              //   ),
              // ),
              const Icon(Icons.chevron_right, color: secondaryText),
            ],
          ),
          const Divider(color: Color(0xFFEBF0F3)),
          const SizedBox(height: 10),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: order.cart?.length ?? 0,
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemBuilder: (context, index) {
              final item = order.cart![index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 112,
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CustomCachedImageNetwork(
                      image: item.images![0],
                      width: 100,
                      height: 112,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Qty: ${item.quantity}',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        SizedBox(height: 14),
                        Text(
                          '\$${item.price}',
                          style: TextStyle(
                            color: theme.primaryColor,
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Icon(
                      Icons.chevron_right,
                      color: secondaryText,
                      size: 28,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // Price breakdown
  Widget _buildOrderSummary(ThemeData theme) {
    return _card(
      color: theme.cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),
          _priceRow(
            'Subtotal (${order.cart?.length ?? 0} item)',
            '\$${order.subTotal?.toStringAsFixed(2)}',
            color: theme.colorScheme.onSurface,
          ),
          const SizedBox(height: 14),
          _priceRow('Shipping Fee', '\$0', color: theme.colorScheme.onSurface),
          const SizedBox(height: 18),
          const Divider(color: Color(0xFFEBF0F3)),
          const SizedBox(height: 8),
          _priceRow(
            'Total',
            '\$${order.subTotal?.toStringAsFixed(2)}',
            bold: true,
            color: theme.colorScheme.onSurface,
          ),
        ],
      ),
    );
  }

  // Reusable card
  Widget _card({required Widget child, Color color = Colors.white}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }

  // Reusable circular icon
  Widget _iconCircle(IconData icon, {double size = 64, double iconSize = 30}) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: lightGreen,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: iconSize, color: primaryGreen),
    );
  }

  Widget _priceRow(
    String label,
    String amount, {
    bool bold = false,
    required Color color,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: bold ? 17 : 14,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            color: bold ? color : Colors.grey,
            fontSize: bold ? 23 : 15,
            fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _OrderStep {
  final String title;
  final bool completed;
  final bool active;
  final IconData icon;

  const _OrderStep({
    required this.title,
    required this.completed,
    this.active = false,
    required this.icon,
  });
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color textColor;
  final Color iconColor;
  const _InfoRow({
    required this.icon,
    required this.text,
    required this.textColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 19, color: iconColor),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 14, height: 1.5),
          ),
        ),
      ],
    );
  }
}

OrderStatus getOrderStatus(String status) {
  switch (status.toLowerCase()) {
    case 'pending':
      return OrderStatus.pending;

    case 'shipped':
      return OrderStatus.shipped;

    case 'delivered':
      return OrderStatus.delivered;

    default:
      return OrderStatus.pending;
  }
}
