import 'dart:convert';

class UserModel {
  UserModel({
    required this.age,
    required this.name,
    required this.email,
  });

  final int age;
  final String name;
  final String email;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'age': age,
      'name': name,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      age: map['age'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(age: $age, name: $name, email: $email)';
}
