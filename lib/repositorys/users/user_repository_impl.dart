import 'dart:developer';

import 'package:aluminex_core/aluminex_core.dart';
import 'package:dio/dio.dart';

import '../../models/user.dart';
import '../../services/service_locator/service_locator.dart';
import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient _restClient = getIt.get<RestClient>();

  @override
  Future<Either<RepositoryException, Unit>> addNewUser(User user) async {
    try {
      await _restClient.auth.post('/users', data: user.toMap());

      return Right(unit);
    } on DioException catch (e, s) {
      log('Erro ao criar novo usuário', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }
}
