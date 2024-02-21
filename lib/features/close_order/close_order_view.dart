import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_web/features/close_order/cubit/close_order_cubit.dart';
import 'package:test_flutter_web/features/close_order/cubit/close_order_cubit_states.dart';
import 'package:test_flutter_web/models/door.dart';
import 'package:test_flutter_web/support/components/door_tile.dart';
import 'package:validatorless/validatorless.dart';

class CloseOrderView extends StatefulWidget {
  const CloseOrderView({super.key});

  @override
  State<CloseOrderView> createState() => _CloseOrderViewState();
}

class _CloseOrderViewState extends State<CloseOrderView> {
  final closeOrderCubit = CloseOrderCubit();

  @override
  void initState() {
    super.initState();
    closeOrderCubit.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final cart = ModalRoute.of(context)!.settings.arguments as List<Door>;
    var sizeOf = MediaQuery.sizeOf(context);
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Close Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: BlocBuilder<CloseOrderCubit, CloseOrderCubitState>(
          bloc: closeOrderCubit,
          builder: (context, state) {
            if (state is CloseOrderErrorState) {
              return Center(
                child: Placeholder(
                  child: Text(state.message),
                ),
              );
            }

            if (state is CloseOrderClosedState) {
              const snackbar = SnackBar(content: Center(child: Text('Pedido feito com sucesso!')));
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              });
              closeOrderCubit.initialize();
            }

            if (state is CloseOrderLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CloseOrderLoadedState) {
              closeOrderCubit.calculateTotalPrice(cart);
              return Form(
                key: formKey,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Revise o pedido',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: sizeOf.width * .6,
                        height: sizeOf.height * .7,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          children: [
                            const Text('CPF Cliente:'),
                            const SizedBox(height: 12),
                            DropdownButtonFormField(
                              icon: const Icon(Icons.arrow_drop_down),
                              menuMaxHeight: 200,
                              validator: Validatorless.required('CPF não pode ser vazio!'),
                              items: state.clients.map((client) {
                                return DropdownMenuItem(
                                  value: client.cpf,
                                  child: Text(client.cpf),
                                );
                              }).toList(),
                              onChanged: closeOrderCubit.updateClientCpf,
                            ),
                            const SizedBox(height: 24),
                            Expanded(
                              child: ListView.builder(
                                itemCount: cart.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DoorTile(door: cart[index]),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 40),
                            Text(
                              'Preço total= R\$${closeOrderCubit.totalPrice}',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          final valid = formKey.currentState!.validate();
                          if (valid) {
                            closeOrderCubit.sendOrder(doors: cart);
                            Navigator.popUntil(context, (route) => route.isFirst);
                            cart.clear();
                          }
                        },
                        style: ElevatedButton.styleFrom(minimumSize: Size(sizeOf.width * .6, 48)),
                        child: const Text('Fazer pedido'),
                      ),
                    ],
                  ),
                ),
              );
            }

            return const Text('Close Order State');
          },
        ),
      ),
    );
  }
}
