import 'package:aluminex_core/aluminex_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_web/repositorys/adm_user/adm_user_respository.dart';
import 'package:test_flutter_web/repositorys/adm_user/adm_user_respository_impl.dart';
import 'package:test_flutter_web/services/service_locator/service_locator.dart';

import './user_login_service.dart';

class UserLoginServiceImpl implements UserLoginService {
  final AdmUserRespository userRespository = AdmUserRespositoryImpl(restClient: getIt.get<RestClient>());

  @override
  Future<Either<ServiceException, Unit>> execute(String email, String password) async {
    final loginResult = await userRespository.login(email, password);

    switch (loginResult) {
      case Left(value: AuthUnauthorizedException()):
        return Left(ServiceException(message: 'Email ou senha inválidos'));
      case Left(value: AuthError()):
        return Left(ServiceException(message: 'Erro ao realizar login'));
      case Right(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStorageConstants.accessToken, accessToken);
        return Right(unit);
    }
  }
}
