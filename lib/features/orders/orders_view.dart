import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_web/features/orders/cubit/order_cubit.dart';
import 'package:test_flutter_web/features/orders/cubit/order_cubit_states.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  final ordersCubit = OrdersCubit();

  @override
  void initState() {
    super.initState();
    ordersCubit.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      body: BlocBuilder<OrdersCubit, OrderCubitStates>(
        bloc: ordersCubit,
        builder: (context, state) {
          if (state is OrderLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is OrderErrorState) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is OrderLoadedState) {
            return Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  width: sizeOf.width * .6,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'PEDIDOS',
                        style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 64),
                      SizedBox(
                        width: sizeOf.width * 0.3,
                        child: const TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Digite o CPF do cliente...'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.orders.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(16),
                              child: Container(
                                margin: const EdgeInsets.all(24),
                                padding: const EdgeInsets.all(12),
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'CPF do cliente: ${state.orders[index].clientDocument}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      'Preço total: R\$ ${state.orders[index].totalPrice.toString()}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      'Status: ${state.orders[index].status.name}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      'Qtd de portas: ${state.orders[index].doors.length.toString()}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }

          return const Text('Erro');
        },
      ),
    );
  }
}
