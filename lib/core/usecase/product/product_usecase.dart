import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shoply_app_dashboard/core/model/categories/request_categories.dart';
import 'package:shoply_app_dashboard/core/model/product/request_products.dart';
import 'package:shoply_app_dashboard/core/service/upload_image_services.dart';

class ProductUsecase {
  Future<Either<String, bool>> addProduct(
    RequestProducts requestproducts,
    String categoryId,
  ) async {
    try {
      final uploadResult = await uploadImages(
        images: requestproducts.images ?? [],
      );

      if (uploadResult.isLeft()) {
        return Left(uploadResult.swap().getOrElse(() => 'Upload failed'));
      }

      final imageUrls = uploadResult.getOrElse(() => []);
      final docRef = FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .collection('products')
          .doc();

      await docRef.set({
        'id': docRef.id,
        'name': requestproducts.name,
        'description': requestproducts.description,
        'price': requestproducts.price,
        'images': imageUrls,
        'isTrending': requestproducts.isTrending,
      });

      return const Right(true);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Firebase error');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<RequestCategories>>> getCategories() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('categories')
          .get();
      final List<RequestCategories> categories = [];
      for (var element in snapshot.docs) {
        categories.add(RequestCategories.fromJson(element.data()));
      }
      return Right(categories);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    } catch (e) {
      return Left(e.toString());
    }
  }
  // Keep your getCategories() implementation here.

  Future<Either<String, List<String>>> uploadImages({
    required List<File> images,
  }) async {
    try {
      final List<String> imageUrls = [];

      for (final image in images) {
        final imageUrl = await _uploadImage(image: image);

        if (imageUrl == null) {
          return const Left('Failed to upload image');
        }

        imageUrls.add(imageUrl);
      }

      return Right(imageUrls);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<String?> _uploadImage({required File? image}) async {
    if (image == null) return null;

    return await UploadImageService.uplaodImage(imageFile: image);
  }
}
