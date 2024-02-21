import 'package:aluminex_core/aluminex_core.dart';
import 'package:test_flutter_web/models/client_order.dart';

abstract interface class OrderRepository {
  Future<Either<RepositoryException, Unit>> createNewOrder(ClientOrder order);
  Future<Either<RepositoryException, List<ClientOrder>>> getAllOrders();
}
