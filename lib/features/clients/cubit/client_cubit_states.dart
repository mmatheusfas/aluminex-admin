import 'package:test_flutter_web/models/client.dart';

abstract class ClientCubitStates {}

class ClientInitialState extends ClientCubitStates {}

class ClientLoadingState extends ClientCubitStates {}

class ClientLoadedState extends ClientCubitStates {
  final List<Client> clients;

  ClientLoadedState({required this.clients});
}

class ClientIsertedState extends ClientCubitStates {}

class ClientErrorState extends ClientCubitStates {
  final String message;

  ClientErrorState({required this.message});
}
