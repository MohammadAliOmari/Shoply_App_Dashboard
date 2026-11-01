abstract class OrderDetailsState {}

class OrderDetailsInitialState extends OrderDetailsState {}

class OrderDetailsLoadingState extends OrderDetailsState {}

class OrderDetailsSucssesState extends OrderDetailsState {}

class OrderDetailsErrorState extends OrderDetailsState {
  final String error;
  OrderDetailsErrorState(this.error);
}
