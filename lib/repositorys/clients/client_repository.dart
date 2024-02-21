import 'package:aluminex_core/aluminex_core.dart';
import 'package:test_flutter_web/models/client.dart';

abstract interface class ClientRepository {
  Future<Either<RepositoryException, List<Client>>> getAllClients();
  Future<Either<RepositoryException, Unit>> addNewClient(Client newClient);
  Future<Either<RepositoryException, Unit>> updateClientHasOrder(int id, Map<String, bool> newHasOrder);
}
