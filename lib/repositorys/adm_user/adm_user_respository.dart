import 'package:aluminex_core/aluminex_core.dart';

abstract interface class AdmUserRespository {
  Future<Either<AuthException, String>> login(String email, String password);
}
