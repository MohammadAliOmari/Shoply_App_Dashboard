import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shoply_app_dashboard/core/service/upload_image_services.dart';

class SalesUsecase {
  Future<Either<String, bool>> addSales({required File? image}) async {
    try {
      if (image == null) {
        return left('Please select a banner image');
      }
      final imageUrl = await _uploadImage(image: image);

      if (imageUrl == null) {
        return left('Failed to upload banner image');
      }

      final ref = FirebaseFirestore.instance.collection('sales').doc();

      await ref.set({'id': ref.id, 'image': imageUrl});

      return const Right(true);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<String?> _uploadImage({required File? image}) async {
    if (image == null) return null;

    return await UploadImageService.uplaodImage(imageFile: image);
  }
}
