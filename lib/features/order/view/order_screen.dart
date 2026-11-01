import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app_dashboard/features/order/view/widgets/order_list.dart';
import 'package:shoply_app_dashboard/features/order/view/widgets/shimmer_order_loading.dart';
import 'package:shoply_app_dashboard/features/order/view_model/cubit.dart';
import 'package:shoply_app_dashboard/features/order/view_model/state.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => OrderCubit()..getOrders(),
      child: DefaultTabController(
        length: 4,
        initialIndex: 0,
        child: Scaffold(
          body: BlocBuilder<OrderCubit, OrderState>(
            builder: (context, state) {
              final cubit = context.read<OrderCubit>();
              if (state is OrderLoadingState) {
                return const OrdersShimmerList();
              }
              if (state is OrderErrorState) {
                return Center(child: Text(state.errorMessage));
              }
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TabBar(
                      dividerHeight: 0,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding: const EdgeInsets.all(3),
                      labelPadding: EdgeInsets.zero,
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      unselectedLabelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      indicator: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      labelColor: theme.colorScheme.surface,
                      unselectedLabelColor: theme.colorScheme.onSurface,
                      tabs: const [
                        Tab(text: 'All'),
                        Tab(text: 'Pending'),
                        Tab(text: 'Shipped'),
                        Tab(text: 'Delivered'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        cubit.ordersList.isEmpty
                            ? Center(child: Text('No Orders Yet'))
                            : OrderList(
                                orderList: cubit.ordersList,
                                status: 'all',
                              ),
                        cubit.ordersList
                                .where((order) => order.status == 'pending')
                                .isEmpty
                            ? Center(child: Text('No Orders Yet'))
                            : OrderList(
                                orderList: cubit.ordersList
                                    .where((order) => order.status == 'pending')
                                    .toList(),
                                status: 'pending',
                              ),
                        cubit.ordersList
                                .where((order) => order.status == 'shipped')
                                .isEmpty
                            ? Center(child: Text('No Orders Yet'))
                            : OrderList(
                                orderList: cubit.ordersList
                                    .where((order) => order.status == 'shipped')
                                    .toList(),
                                status: 'shipped',
                              ),
                        cubit.ordersList
                                .where((order) => order.status == 'delivered')
                                .isEmpty
                            ? Center(child: Text('No Orders Yet'))
                            : OrderList(
                                orderList: cubit.ordersList
                                    .where(
                                      (order) => order.status == 'delivered',
                                    )
                                    .toList(),
                                status: 'delivered',
                              ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
