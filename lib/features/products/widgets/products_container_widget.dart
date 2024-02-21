import 'package:flutter/material.dart';
import 'package:test_flutter_web/features/products/cubit/product_cubit_states.dart';

import '../../../models/product.dart';

class ProductContainerWidget extends StatelessWidget {
  final List<Product> products;
  final String productType;
  final ProductCubitStates state;

  const ProductContainerWidget({
    super.key,
    required this.products,
    required this.productType,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    var sizeOf = MediaQuery.sizeOf(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        children: [
          Text(productType, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              label: Text('Digite o nome do $productType'),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: sizeOf.height * .3,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                indent: 10,
                endIndent: 10,
                color: Colors.black.withOpacity(.5),
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Row(
                      children: [
                        Text(
                          '${index + 1}-',
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        Text(
                          products[index].name,
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
