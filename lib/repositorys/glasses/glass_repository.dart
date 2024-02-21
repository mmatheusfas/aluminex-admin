import 'package:aluminex_core/aluminex_core.dart';
import 'package:test_flutter_web/models/glass.dart';

abstract interface class GlassRepository {
  Future<Either<RepositoryException, List<Glass>>> getGlasses();
  Future<Either<RepositoryException, Unit>> addNewGlass(Glass newGlass);
}
