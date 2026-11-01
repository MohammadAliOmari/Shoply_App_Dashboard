import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shoply_app_dashboard/core/model/categories/request_categories.dart';
import 'package:shoply_app_dashboard/core/model/product/request_products.dart';
import 'package:shoply_app_dashboard/core/usecase/product/product_usecase.dart';

class AddProductRepo {
  final _productUsecase = ProductUsecase();
  Future<Either<String, bool>> addProduct({
    required RequestProducts requestproducts,
    required String categoryId,
  }) {
    return _productUsecase.addProduct(requestproducts, categoryId);
  }

  Future<Either<String, List<RequestCategories>>> getCategories() {
    return _productUsecase.getCategories();
  }

  Future<Either<String, List<String>>> uploadImages({
    required List<File> images,
  }) {
    return _productUsecase.uploadImages(images: images);
  }
}
