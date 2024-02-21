import 'package:test_flutter_web/features/budget/models/order_status.dart';
import 'package:test_flutter_web/models/door.dart';

class ClientOrder {
  String clientDocument;
  double totalPrice;
  OrderStatus status;
  DateTime createdAt;
  List<Door> doors;

  ClientOrder({
    required this.clientDocument,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    required this.doors,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'client_document': clientDocument,
      'created_at': createdAt.toIso8601String(),
      'total_price': totalPrice,
      'status': status.name,
      'doors': doors.map((e) => e.toMap()).toList(),
    };
  }

  factory ClientOrder.fromMap(Map<String, dynamic> map) {
    return ClientOrder(
      totalPrice: map['total_price'],
      status: OrderStatus.getOrderStatusByName(map['status']),
      clientDocument: map['client_document'],
      createdAt: DateTime.parse(map['created_at']),
      doors: Door.fromMapList(map['doors']),
    );
  }

  static List<ClientOrder> fromMapList(List mapList) {
    return mapList.map((map) => ClientOrder.fromMap(map)).toList();
  }
}
