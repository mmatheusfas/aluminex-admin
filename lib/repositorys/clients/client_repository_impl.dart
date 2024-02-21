import 'dart:developer';

import 'package:aluminex_core/aluminex_core.dart';
import 'package:dio/dio.dart';
import 'package:test_flutter_web/models/client.dart';

import '../../services/service_locator/service_locator.dart';
import './client_repository.dart';

class ClientRepositoryImpl implements ClientRepository {
  final RestClient _restClient = getIt.get<RestClient>();

  @override
  Future<Either<RepositoryException, List<Client>>> getAllClients() async {
    try {
      final Response(:data) = await _restClient.auth.get('/clients');

      return Right(Client.fromMapList(data));
    } on DioException catch (e, s) {
      log('Erro ao buscar clientes', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }

  @override
  Future<Either<RepositoryException, Unit>> addNewClient(Client newClient) async {
    try {
      await _restClient.auth.post('/clients', data: newClient.toMap());
      return Right(unit);
    } on DioException catch (e, s) {
      log('Erro ao adicionar novo cliente', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }

  @override
  Future<Either<RepositoryException, Unit>> updateClientHasOrder(int id, Map<String, bool> newHasOrder) async {
    try {
      await _restClient.auth.put('/clients/$id', data: newHasOrder);
      return Right(unit);
    } on DioException catch (e, s) {
      log('Erro ao atualizar cliente', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }
}
