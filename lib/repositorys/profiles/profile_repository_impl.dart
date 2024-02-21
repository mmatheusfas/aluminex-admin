import 'dart:developer';

import 'package:aluminex_core/aluminex_core.dart';
import 'package:dio/dio.dart';
import 'package:test_flutter_web/models/profile.dart';

import '../../services/service_locator/service_locator.dart';
import './profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final RestClient _restClient = getIt.get<RestClient>();

  @override
  Future<Either<RepositoryException, Unit>> addNewProfile(Profile newProfile) async {
    try {
      await _restClient.auth.post('/profiles', data: newProfile.toMap());
      return Right(unit);
    } on DioException catch (e, s) {
      log('Erro ao adicionar um novo perfil', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }

  @override
  Future<Either<RepositoryException, List<Profile>>> getProfiles() async {
    try {
      final Response(:data) = await _restClient.auth.get('/profiles');

      return Right(Profile.fromMapList(data));
    } on DioException catch (e, s) {
      log('Erro ao buscar perfis', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }
}
