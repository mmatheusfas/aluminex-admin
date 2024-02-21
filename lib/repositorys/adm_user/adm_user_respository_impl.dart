import 'dart:developer';
import 'dart:io';

import 'package:aluminex_core/aluminex_core.dart';
import 'package:dio/dio.dart';

import 'adm_user_respository.dart';

class AdmUserRespositoryImpl implements AdmUserRespository {
  final RestClient restClient;
  AdmUserRespositoryImpl({required this.restClient});

  @override
  Future<Either<AuthException, String>> login(String email, String password) async {
    try {
      final Response(data: {'access_token': accessToken}) = await restClient.unAuth.post(
        '/auth',
        data: {
          "email": email,
          "password": password,
          "admin": true,
        },
      );

      return Right(accessToken);
    } catch (e, s) {
      log('Erro ao fazer login repository!', error: e, stackTrace: s);
      switch (e) {
        case DioException(response: Response(statusCode: HttpStatus.forbidden)):
          return Left(AuthUnauthorizedException());
        default:
          return Left(AuthError(message: 'Erro ao realizar login'));
      }
    }
  }
}
