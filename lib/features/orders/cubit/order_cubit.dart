import 'package:aluminex_core/aluminex_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_web/features/orders/cubit/order_cubit_states.dart';
import 'package:test_flutter_web/repositorys/orders/order_repository.dart';
import 'package:test_flutter_web/repositorys/orders/order_repository_impl.dart';

class OrdersCubit extends Cubit<OrderCubitStates> {
  OrdersCubit() : super(OrderInitialState());

  final OrderRepository _orderRepository = OrderRepositoryImpl();

  void initialize() async {
    await _getAllOrders();
  }

  Future<void> _getAllOrders() async {
    emit(OrderLoadingState());

    final result = await _orderRepository.getAllOrders();

    switch (result) {
      case Right(value: final ordersList):
        emit(OrderLoadedState(orders: ordersList));
      case Left(value: RepositoryException()):
        emit(OrderErrorState(message: 'Erro ao buscar pedidos'));
    }
  }
}
