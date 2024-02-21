import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_web/features/clients/cubit/client_cubit.dart';
import 'package:test_flutter_web/features/clients/cubit/client_cubit_states.dart';
import 'package:test_flutter_web/features/products/cubit/product_cubit_states.dart';
import 'package:validatorless/validatorless.dart';

class CustomClientModalWidget extends StatelessWidget {
  final ClientCubit clientCubit;

  const CustomClientModalWidget({super.key, required this.clientCubit});

  @override
  Widget build(BuildContext context) {
    final nameEC = TextEditingController();
    final emailEC = TextEditingController();
    final phoneEC = TextEditingController();
    final documentEC = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return BlocBuilder<ClientCubit, ClientCubitStates>(
      bloc: clientCubit,
      builder: (context, state) {
        if (state is ClientErrorState) {
          return Center(
            child: Text(state.message),
          );
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Novo cliente',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: nameEC,
                  validator: Validatorless.required('Nome não pode ser vazio!'),
                  decoration: const InputDecoration(
                    label: Text('Digite o nome'),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('E-mail não pode ser vazio!'),
                    Validatorless.email('E-mail inválido!'),
                  ]),
                  decoration: const InputDecoration(
                    label: Text('Digite o email'),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: phoneEC,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                  validator: Validatorless.multiple([
                    Validatorless.required('Telefone não pode ser vazio!'),
                  ]),
                  decoration: const InputDecoration(
                    label: Text('Digite o telefone'),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: documentEC,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter(),
                  ],
                  validator: Validatorless.multiple([
                    Validatorless.required('CPF não pode ser vazio!'),
                    Validatorless.cpf('CPF inválido!'),
                  ]),
                  decoration: const InputDecoration(
                    label: Text('Digite o CPF'),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    final valid = formKey.currentState!.validate();
                    final navigator = Navigator.of(context);
                    if (valid) {
                      await clientCubit.insertNewClient(
                        nameEC.text,
                        emailEC.text,
                        phoneEC.text,
                        documentEC.text,
                      );
                      navigator.pop();
                    }
                  },
                  child: state is ProductLoadingState ? const CircularProgressIndicator() : const Text('Adicionar'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
