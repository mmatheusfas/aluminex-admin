import 'package:aluminex_core/aluminex_core.dart';
import 'package:test_flutter_web/models/user.dart';

abstract interface class UserRepository {
  Future<Either<RepositoryException, Unit>> addNewUser(User user);
}
