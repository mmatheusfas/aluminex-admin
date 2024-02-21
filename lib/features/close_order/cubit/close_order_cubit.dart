import 'dart:developer';

import 'package:aluminex_core/aluminex_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_web/features/budget/models/order_status.dart';
import 'package:test_flutter_web/features/close_order/cubit/close_order_cubit_states.dart';
import 'package:test_flutter_web/models/client_order.dart';
import 'package:test_flutter_web/models/user.dart';
import 'package:test_flutter_web/repositorys/orders/order_repository.dart';
import 'package:test_flutter_web/repositorys/orders/order_repository_impl.dart';
import 'package:test_flutter_web/repositorys/users/user_repository.dart';
import 'package:test_flutter_web/repositorys/users/user_repository_impl.dart';
import 'package:test_flutter_web/services/service_locator/service_locator.dart';

import '../../../models/client.dart';
import '../../../models/door.dart';
import '../../../repositorys/clients/client_repository.dart';

class CloseOrderCubit extends Cubit<CloseOrderCubitState> {
  CloseOrderCubit() : super(CloseOrderInitialState());

  final ClientRepository _clientRepository = getIt.get<ClientRepository>();
  final OrderRepository _orderRepository = OrderRepositoryImpl();
  final UserRepository _userRepository = UserRepositoryImpl();

  List<Client> _clients = [];

  String _clientCPF = '';
  double _totalPrice = 0.0;

  double get totalPrice => _totalPrice;

  void initialize() async {
    emit(CloseOrderLoadingState());
    try {
      await _getClients();
      emit(CloseOrderLoadedState(clients: _clients));
    } on RepositoryException catch (e, s) {
      log('Erro ao buscar clientes', error: e, stackTrace: s);
      emit(CloseOrderErrorState(message: 'Erro ao buscar clientes'));
    }
  }

  void sendOrder({required List<Door> doors}) async {
    emit(CloseOrderLoadingState());

    final order = ClientOrder(
      clientDocument: _clientCPF,
      totalPrice: _totalPrice,
      status: OrderStatus.pedidoFeito,
      createdAt: DateTime.now(),
      doors: doors,
    );

    try {
      await _orderRepository.createNewOrder(order);
      await _createClientUser();
      emit(CloseOrderClosedState());
    } catch (e, s) {
      log('Erro ao concluir pedido', error: e, stackTrace: s);
      emit(CloseOrderErrorState(message: 'Erro ao concluir pedido'));
    }
  }

  void calculateTotalPrice(List<Door> doors) {
    for (var door in doors) {
      _totalPrice += door.preco;
    }
  }

  void updateClientCpf(String? newClientCPF) {
    if (newClientCPF == null) return;

    _clientCPF = newClientCPF;
  }

  Future<void> _createClientUser() async {
    late Client finalClient;
    late int index;
    for (var i = 0; i < _clients.length; i++) {
      if (_clients[i].cpf == _clientCPF) {
        finalClient = _clients[i];
        index = i;
      }
    }

    if (!finalClient.hasOrder) {
      final result = await _userRepository.addNewUser(
        User(email: finalClient.email, password: finalClient.cpf),
      );

      switch (result) {
        case Left(value: RepositoryException()):
          return;
        case Right():
          await _clientRepository.updateClientHasOrder(index + 1, {'has_order': true});
          return;
      }
    }
  }

  Future<void> _getClients() async {
    final result = await _clientRepository.getAllClients();

    switch (result) {
      case Left(value: RepositoryException()):
        return;
      case Right(value: final clientsList):
        _clients = clientsList;
    }
  }
}
