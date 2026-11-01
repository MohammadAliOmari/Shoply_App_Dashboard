abstract class AddSalesState {}

class AddSalesInitialState extends AddSalesState {}

class AddSalesLoadingState extends AddSalesState {}

class AddSalesSuccessState extends AddSalesState {}

class AddSalesErrorState extends AddSalesState {
  final String message;
  AddSalesErrorState({required this.message});
}

class PickImageState extends AddSalesState {}

class RemoveImageState extends AddSalesState {}
