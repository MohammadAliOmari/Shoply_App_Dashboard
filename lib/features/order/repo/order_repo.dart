import 'package:dartz/dartz.dart';
import 'package:shoply_app_dashboard/core/model/order/response_order.dart';
import 'package:shoply_app_dashboard/core/usecase/order/order_usecase.dart';

class OrderRepo {
  final _orderUsecase = OrderUsecase();

  Future<Either<String, List<OrderResponse>>> getOrders() async {
    return await _orderUsecase.getOrders();
  }
}
