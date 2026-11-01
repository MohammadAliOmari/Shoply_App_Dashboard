import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shoply_app_dashboard/core/usecase/sales/sales_usecase.dart';

class SalesRepo {
  final _salesUseCase = SalesUsecase();

  Future<Either<String, bool>> addSales({required File image}) async {
    return await _salesUseCase.addSales(image: image);
  }
}
