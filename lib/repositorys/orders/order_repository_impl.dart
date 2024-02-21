import 'dart:developer';

import 'package:aluminex_core/aluminex_core.dart';
import 'package:dio/dio.dart';
import 'package:test_flutter_web/models/client_order.dart';

import '../../services/service_locator/service_locator.dart';
import './order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final RestClient _restClient = getIt.get<RestClient>();

  @override
  Future<Either<RepositoryException, Unit>> createNewOrder(ClientOrder order) async {
    try {
      await _restClient.auth.post('/orders', data: order.toMap());

      return Right(unit);
    } on DioException catch (e, s) {
      log('Erro ao criar pedido', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }

  @override
  Future<Either<RepositoryException, List<ClientOrder>>> getAllOrders() async {
    try {
      final Response(:data) = await _restClient.auth.get('/orders');

      return Right(ClientOrder.fromMapList(data));
    } on DioException catch (e, s) {
      log('Erro ao buscar pedidos', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }
}
