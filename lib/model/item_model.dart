import 'package:faker/faker.dart';

class UserModelA {
  UserModelA({
    required this.id,
    required this.name,
    required this.phone,
  });

  final int id;
  final String name;
  final String phone;

  @override
  bool operator ==(covariant UserModelA other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.phone == phone;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ phone.hashCode;

  @override
  String toString() => 'ItemModel(id: $id, name: $name, price: $phone)';

  static List<UserModelA> get getDemoItems {
    return List.generate(
      20,
      (index) => UserModelA(
        id: faker.currency.random.integer(20000, min: 300),
        name: faker.person.name(),
        phone: faker.phoneNumber.us(),
      ),
    );
  }
}
