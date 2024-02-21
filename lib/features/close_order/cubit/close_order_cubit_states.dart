import 'package:test_flutter_web/models/client.dart';

abstract class CloseOrderCubitState {}

class CloseOrderInitialState extends CloseOrderCubitState {}

class CloseOrderLoadingState extends CloseOrderCubitState {}

class CloseOrderLoadedState extends CloseOrderCubitState {
  final List<Client> clients;

  CloseOrderLoadedState({required this.clients});
}

class CloseOrderClosedState extends CloseOrderCubitState {}

class CloseOrderErrorState extends CloseOrderCubitState {
  final String message;

  CloseOrderErrorState({required this.message});
}
