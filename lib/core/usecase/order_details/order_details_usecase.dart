import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class OrderDetailsUsecase {
  Future<Either<String, bool>> updateOrderStatus(
    String status,
    String orderId,
  ) async {
    // Update Firestore
    try {
      await FirebaseFirestore.instance.collection('Order').doc(orderId).update({
        'status': status,
      });
      return right(true);
    } catch (e) {
      return left(e.toString());
    }
  }
}
