import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app_dashboard/core/model/categories/request_categories.dart';
import 'package:shoply_app_dashboard/core/model/product/request_products.dart';
import 'package:shoply_app_dashboard/core/service/image_pick_helper.dart';
import 'package:shoply_app_dashboard/features/add_product/repo/add_product_repo.dart';
import 'package:shoply_app_dashboard/features/add_product/view_model/state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitialState());

  final _addproductRepo = AddProductRepo();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final List<RequestCategories> categories = [];
  final List<File> images = [];
  final formKey = GlobalKey<FormState>();
  bool isTrending = false;
  RequestCategories? selectedCategory;

  void changeCategory(RequestCategories? value) {
    selectedCategory = value;
    emit(AddProductCategoryChangedState());
  }

  Future<void> pickImage() async {
    final imageFile = await ImagePickerHelper.pickImageGallery();

    if (imageFile == null) return;

    images.add(File(imageFile.path));

    emit(PickImageState());
  }

  void deleteImage(int index) {
    if (index < 0 || index >= images.length) return;

    images.removeAt(index);

    emit(RemoveImageState());
  }

  Future<void> addProduct() async {
    final price = double.tryParse(priceController.text.trim());

    if (formKey.currentState!.validate() &&
        selectedCategory != null &&
        images.isNotEmpty) {
      emit(AddProductLoadingState());

      final result = await _addproductRepo.addProduct(
        requestproducts: RequestProducts(
          name: nameController.text.trim(),
          description: descriptionController.text.trim(),
          price: price,
          images: images,
          isTrending: isTrending,
        ),
        categoryId: selectedCategory!.id,
      );

      result.fold(
        (error) {
          emit(AddProductErrorState(message: error));
        },
        (_) {
          clearForm();
          emit(AddProductSuccessState());
        },
      );
    }
  }

  void changeIsTrending(bool value) {
    isTrending = value;
    emit(AddProductIsTrendingChangedState());
  }

  Future<void> getCategories() async {
    emit(GetCategoriesLoadingState());

    final result = await _addproductRepo.getCategories();

    result.fold(
      (error) {
        emit(GetCategoriesErrorState(message: error));
      },
      (data) {
        categories
          ..clear()
          ..addAll(data);

        emit(GetCategoriesSuccessState());
      },
    );
  }

  void clearForm() {
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
    isTrending = false;
    images.clear();
    selectedCategory = null;
  }

  @override
  Future<void> close() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    return super.close();
  }
}
