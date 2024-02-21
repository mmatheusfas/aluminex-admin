import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_web/features/products/cubit/product_cubit_states.dart';
import 'package:validatorless/validatorless.dart';

import '../cubit/product_cubit.dart';

class CustomModalWidget extends StatelessWidget {
  final ProductCubit productCubit;
  const CustomModalWidget({super.key, required this.productCubit});

  @override
  Widget build(BuildContext context) {
    final nameEC = TextEditingController();
    final priceEC = TextEditingController();
    final formKey = GlobalKey<FormState>();
    String productType = '';

    return BlocBuilder<ProductCubit, ProductCubitStates>(
      bloc: productCubit,
      builder: (context, state) {
        if (state is ProductErrorState) {
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
                  'Novo produto',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                  validator: Validatorless.required('O tipo do produto não pode ser vazio!'),
                  decoration: const InputDecoration(
                    label: Text('Qual o tipo do produto?'),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Profiles',
                      child: Text('Perfil'),
                    ),
                    DropdownMenuItem(
                      value: 'Glasses',
                      child: Text('Vidro'),
                    ),
                    DropdownMenuItem(
                      value: 'Pullers',
                      child: Text('Puxador'),
                    ),
                  ],
                  onChanged: (value) {
                    productType = value ?? '';
                  },
                ),
                const Spacer(flex: 1),
                TextFormField(
                  controller: nameEC,
                  validator: Validatorless.required('Nome não pode ser vazio!'),
                  decoration: const InputDecoration(
                    label: Text('Digite o nome'),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: priceEC,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: Validatorless.required('Preço não pode ser vazio!'),
                  decoration: const InputDecoration(
                    label: Text('Digite o preço'),
                  ),
                ),
                const Spacer(flex: 2),
                ElevatedButton(
                  onPressed: () {
                    final valid = formKey.currentState!.validate();
                    if (valid) {
                      productCubit.insertNewProduct(
                        productType,
                        nameEC.text,
                        priceEC.text,
                      );
                      Navigator.of(context).pop();
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
