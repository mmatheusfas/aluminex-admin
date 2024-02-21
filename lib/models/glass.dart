import 'package:test_flutter_web/models/product.dart';

class Glass extends Product {
  Glass({required String name, required double price}) : super(name: name, price: price);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'price': price,
    };
  }

  factory Glass.fromMap(Map<String, dynamic> map) {
    return Glass(
      name: map['name'],
      price: map['price'],
    );
  }

  static List<Glass> fromMapList(List mapList) {
    return mapList.map((map) => Glass.fromMap(map)).toList();
  }
}
