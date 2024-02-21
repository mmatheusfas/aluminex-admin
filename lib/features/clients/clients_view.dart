import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_web/features/clients/cubit/client_cubit.dart';
import 'package:test_flutter_web/features/clients/cubit/client_cubit_states.dart';
import 'package:test_flutter_web/features/clients/widgets/client_tile_widget.dart';
import 'package:test_flutter_web/features/clients/widgets/custom_client_modal_widget.dart';

class ClientsView extends StatefulWidget {
  const ClientsView({super.key});

  @override
  State<ClientsView> createState() => _ClientsViewState();
}

class _ClientsViewState extends State<ClientsView> {
  final clientCubit = ClientCubit();
  @override
  void initState() {
    super.initState();
    clientCubit.initialize();
  }

  @override
  Widget build(BuildContext context) {
    var sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showModal,
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: BlocBuilder<ClientCubit, ClientCubitStates>(
        bloc: clientCubit,
        builder: (context, state) {
          if (state is ClientLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ClientIsertedState) {
            const snackbar = SnackBar(content: Center(child: Text('Cliente adicionado com sucesso!')));
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            });
            clientCubit.initialize();
          }

          if (state is ClientLoadedState) {
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
                        'CLIENTES',
                        style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 64),
                      SizedBox(
                        width: sizeOf.width * 0.3,
                        child: const TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Digite o nome do cliente...'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.clients.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              direction: DismissDirection.endToStart,
                              key: ValueKey<int>(index),
                              background: Container(
                                margin: const EdgeInsets.all(24),
                                height: 48,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  // borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.delete),
                                ),
                              ),
                              child: InkWell(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  '/client-detail',
                                  arguments: state.clients[index],
                                ),
                                child: ClientTileWidget(client: state.clients[index]),
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

  void _showModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CustomClientModalWidget(clientCubit: clientCubit);
      },
    );
  }
}
