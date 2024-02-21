import 'package:flutter/material.dart';
import 'package:test_flutter_web/features/clients/client_details/client_details_view_model.dart';
import 'package:test_flutter_web/models/client.dart';

class ClientDetailsView extends StatefulWidget {
  const ClientDetailsView({super.key});

  @override
  State<ClientDetailsView> createState() => _ClientDetailsViewState();
}

class _ClientDetailsViewState extends State<ClientDetailsView> {
  final ClientDetailsViewModel viewModel = ClientDetailsViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final client = ModalRoute.of(context)!.settings.arguments as Client;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Details'),
        centerTitle: true,
      ),
      body: ListenableBuilder(
          listenable: viewModel,
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Name:'),
                    Text(client.name),
                    const SizedBox(height: 12),
                    const Text('Cpf:'),
                    Text(client.cpf),
                    const SizedBox(height: 12),
                    const Text('Email:'),
                    Text(client.email),
                    const SizedBox(height: 12),
                    const Text('Telefone:'),
                    Text(client.phone),
                    const SizedBox(height: 12),
                    const Text('Has Order:'),
                    Text(client.hasOrder.toString()),
                    /* Expanded(
                      child: ListView.builder(
                        itemCount: viewModel.orders.length,
                        itemBuilder: (_, index) {
                          final order = viewModel.orders[index];
                          if (viewModel.isLoading && viewModel.orders.isEmpty) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return Column(
                            children: [
                              Text(order.totalPrice.toString()),
                              Text(order.status.name),
                            ],
                          );
                        },
                      ),
                    ), */
                  ],
                ),
              ),
            );
          }),
    );
  }
}
