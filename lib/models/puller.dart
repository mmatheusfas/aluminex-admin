import 'package:test_flutter_web/models/product.dart';

class Puller extends Product {
  Puller({required String name, required double price}) : super(name: name, price: price);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'price': price,
    };
  }

  factory Puller.fromMap(Map<String, dynamic> map) {
    return Puller(
      name: map['name'],
      price: map['price'],
    );
  }

  static List<Puller> fromMapList(List mapList) {
    return mapList.map((map) => Puller.fromMap(map)).toList();
  }
}
