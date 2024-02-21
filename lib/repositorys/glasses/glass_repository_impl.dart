import 'dart:developer';

import 'package:aluminex_core/aluminex_core.dart';
import 'package:dio/dio.dart';
import 'package:test_flutter_web/models/glass.dart';

import '../../services/service_locator/service_locator.dart';
import './glass_repository.dart';

class GlassRepositoryImpl implements GlassRepository {
  final RestClient _restClient = getIt.get<RestClient>();

  @override
  Future<Either<RepositoryException, Unit>> addNewGlass(Glass newGlass) async {
    try {
      await _restClient.auth.post('/glasses', data: newGlass.toMap());
      return Right(unit);
    } on DioException catch (e, s) {
      log('Erro ao adicionar um novo vidro', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }

  @override
  Future<Either<RepositoryException, List<Glass>>> getGlasses() async {
    try {
      final Response(:data) = await _restClient.auth.get('/glasses');

      return Right(Glass.fromMapList(data));
    } on DioException catch (e, s) {
      log('Erro ao buscar vidros', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }
}
