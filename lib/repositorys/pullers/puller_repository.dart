import 'package:aluminex_core/aluminex_core.dart';
import 'package:test_flutter_web/models/puller.dart';

abstract interface class PullerRepository {
  Future<Either<RepositoryException, List<Puller>>> getPullers();
  Future<Either<RepositoryException, Unit>> addNewPuller(Puller newPuller);
}
