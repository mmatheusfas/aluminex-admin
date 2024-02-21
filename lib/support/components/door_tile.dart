import 'package:flutter/material.dart';
import 'package:test_flutter_web/models/door.dart';

class DoorTile extends StatelessWidget {
  final Door door;

  const DoorTile({super.key, required this.door});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.grey,
      ),
      child: Row(
        children: [
          Text(
            '${door.quantidade}x',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Text('Porta ${door.altura} x ${door.largura}', style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(
            ' - ${door.perfil} / ${door.vidro} / ${door.puxador}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          Text(
            'R\$ ${door.preco}',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
