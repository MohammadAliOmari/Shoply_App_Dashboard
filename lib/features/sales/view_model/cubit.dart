import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shoply_app_dashboard/core/service/image_pick_helper.dart';
import 'package:shoply_app_dashboard/features/sales/repo/sales_repo.dart';
import 'package:shoply_app_dashboard/features/sales/view_model/state.dart';

class AddSalesCubit extends Cubit<AddSalesState> {
  AddSalesCubit() : super(AddSalesInitialState());
  final _salesRepo = SalesRepo();
  File? selectedImage;

  Future<void> addSales() async {
    emit(AddSalesLoadingState());

    final result = await _salesRepo.addSales(image: selectedImage!);

    result.fold(
      (l) {
        emit(AddSalesErrorState(message: l));
      },
      (r) {
        deleteImage();
        emit(AddSalesSuccessState());
      },
    );
  }

  void pickImage() async {
    final imageFile = await ImagePickerHelper.pickImageGallery();
    selectedImage = File(imageFile?.path ?? '');
    emit(PickImageState());
  }

  void deleteImage() {
    selectedImage = null;
    emit(RemoveImageState());
  }
}
