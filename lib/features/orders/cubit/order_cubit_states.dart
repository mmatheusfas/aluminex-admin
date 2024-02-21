import 'package:test_flutter_web/models/client_order.dart';

abstract class OrderCubitStates {}

class OrderInitialState extends OrderCubitStates {}

class OrderLoadingState extends OrderCubitStates {}

class OrderLoadedState extends OrderCubitStates {
  final List<ClientOrder> orders;

  OrderLoadedState({required this.orders});
}

class OrderErrorState extends OrderCubitStates {
  final String message;

  OrderErrorState({required this.message});
}
