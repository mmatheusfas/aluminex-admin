import 'dart:developer';

import 'package:aluminex_core/aluminex_core.dart';
import 'package:dio/dio.dart';
import 'package:test_flutter_web/models/puller.dart';

import '../../services/service_locator/service_locator.dart';
import 'puller_repository.dart';

class PullerRepositoryImpl implements PullerRepository {
  final RestClient _restClient = getIt.get<RestClient>();

  @override
  Future<Either<RepositoryException, Unit>> addNewPuller(Puller newPuller) async {
    try {
      await _restClient.auth.post('/pullers', data: newPuller.toMap());
      return Right(unit);
    } on DioException catch (e, s) {
      log('Erro ao adicionar um novo puxador', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }

  @override
  Future<Either<RepositoryException, List<Puller>>> getPullers() async {
    try {
      final Response(:data) = await _restClient.auth.get('/pullers');

      return Right(Puller.fromMapList(data));
    } on DioException catch (e, s) {
      log('Erro ao buscar puxadores', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }
}
