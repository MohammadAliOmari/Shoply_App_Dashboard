import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app_dashboard/core/model/order/response_order.dart';
import 'package:shoply_app_dashboard/features/order_details/repo/order_details_repo.dart';
import 'package:shoply_app_dashboard/features/order_details/view_model/state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit() : super(OrderDetailsInitialState());
  final _orderDetailsRepo = OrderDetailsRepo();

  Future<void> updateOrderStatus({
    required OrderResponse order,
    required String status,
  }) async {
    emit(OrderDetailsLoadingState());
    final snapshot = await _orderDetailsRepo.updateOrderStatus(status, order.id!);
    snapshot.fold(
      (errorMessage) {
        emit(OrderDetailsErrorState(errorMessage));
      },
      (_) {
        order.status = status;
        emit(OrderDetailsSucssesState());
      },
    );
  }
}
