import 'package:test_flutter_web/models/product.dart';

class Profile extends Product {
  Profile({required String name, required double price}) : super(name: name, price: price);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'price': price,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      name: map['name'],
      price: map['price'],
    );
  }

  static List<Profile> fromMapList(List mapList) {
    return mapList.map((map) => Profile.fromMap(map)).toList();
  }
}
