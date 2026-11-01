abstract class AddProductState {}

class AddProductInitialState extends AddProductState {}

class AddProductLoadingState extends AddProductState {}

class AddProductSuccessState extends AddProductState {}

class AddProductErrorState extends AddProductState {
  final String message;
  AddProductErrorState({required this.message});
}

class GetCategoriesLoadingState extends AddProductState {}

class GetCategoriesSuccessState extends AddProductState {}

class GetCategoriesErrorState extends AddProductState {
  final String message;

  GetCategoriesErrorState({required this.message});
}

class AddProductCategoryChangedState extends AddProductState {}

class PickImageState extends AddProductState {}

class RemoveImageState extends AddProductState {}

class AddProductIsTrendingChangedState extends AddProductState {}
