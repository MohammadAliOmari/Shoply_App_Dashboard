import 'package:shoply_app_dashboard/core/model/cart/cart.dart';

class OrderResponse {
  String? id;
  final String? userUid;
  final String? fullName;
  final String? address;
  final double? subTotal;
  String? status;
  final List<Cart>? cart;

  OrderResponse({
    this.id,
    required this.userUid,
    required this.fullName,
    required this.address,
    required this.subTotal,
    required this.cart,
    required this.status,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
    id: json['id'],
    userUid: json['userUid'],
    fullName: json['fullName'],
    address: json['address'],
    subTotal: json['subTotal'],
    cart: json['cart'].map<Cart>((x) => Cart.fromJson(x)).toList(),
    status: json['status'],
  );
}
