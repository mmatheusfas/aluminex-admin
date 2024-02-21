import 'package:aluminex_core/aluminex_core.dart';
import 'package:test_flutter_web/models/profile.dart';

abstract interface class ProfileRepository {
  Future<Either<RepositoryException, List<Profile>>> getProfiles();
  Future<Either<RepositoryException, Unit>> addNewProfile(Profile newProfile);
}
