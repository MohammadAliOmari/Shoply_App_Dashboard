import 'package:dartz/dartz.dart';
import 'package:shoply_app_dashboard/core/usecase/order_details/order_details_usecase.dart';

class OrderDetailsRepo {
  final _orderDetailsUsecase = OrderDetailsUsecase();
  Future<Either<String, bool>> updateOrderStatus(
    String status,
    String orderId,
  ) {
    return _orderDetailsUsecase.updateOrderStatus(status, orderId);
  }
}
