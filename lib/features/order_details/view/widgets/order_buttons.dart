import 'package:flutter/material.dart';

class OrderStatusButton extends StatelessWidget {
  final OrderStatus status;
  final ValueChanged<OrderStatus> onChanged;

  const OrderStatusButton({
    super.key,
    required this.status,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (status == OrderStatus.delivered) {
      return const Text(
        'Order Completed',
        textAlign: TextAlign.center,
        style: TextStyle(color: Color(0xFF0A5C43), fontWeight: FontWeight.bold),
      );
    }

    final nextStatus = status == OrderStatus.pending
        ? OrderStatus.shipped
        : OrderStatus.delivered;

    final buttonText = status == OrderStatus.pending
        ? 'Mark as Shipped'
        : 'Mark as Delivered';

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => onChanged(nextStatus),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0A5C43),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: Text(buttonText),
      ),
    );
  }
}

enum OrderStatus { pending, shipped, delivered }
