import 'package:aluminex_core/aluminex_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_web/features/clients/cubit/client_cubit_states.dart';
import 'package:test_flutter_web/models/client.dart';
import 'package:test_flutter_web/repositorys/clients/client_repository.dart';

import '../../../services/service_locator/service_locator.dart';

class ClientCubit extends Cubit<ClientCubitStates> {
  ClientCubit() : super(ClientInitialState());

  final ClientRepository _clientRepository = getIt.get<ClientRepository>();

  void initialize() async {
    await _getClients();
  }

  Future<void> insertNewClient(String name, String email, String phone, String document) async {
    final newClient = Client(
      name: name,
      cpf: document,
      email: email,
      phone: phone,
    );

    final result = await _clientRepository.addNewClient(newClient);

    switch (result) {
      case Left(value: RepositoryException()):
        emit(ClientErrorState(message: 'Erro ao adicionar perfil'));
      case Right():
        emit(ClientIsertedState());
    }
  }

  Future<void> _getClients() async {
    emit(ClientLoadingState());

    final result = await _clientRepository.getAllClients();

    switch (result) {
      case Right(value: final clientsList):
        emit(ClientLoadedState(clients: clientsList));
      case Left(value: RepositoryException()):
        emit(ClientErrorState(message: 'Erro ao buscar clientes'));
    }
  }
}
