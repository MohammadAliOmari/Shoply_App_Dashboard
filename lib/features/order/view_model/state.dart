abstract class OrderState {}

class OrderInitState extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrderSuccessState extends OrderState {}

class OrderErrorState extends OrderState {
  final String errorMessage;

  OrderErrorState({required this.errorMessage});
}
