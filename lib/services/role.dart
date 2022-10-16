import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:navigation_testing/model/role_model.dart';

final roleProvider = StreamProvider<RoleModel>((ref) {
  final fire = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  final uid = user?.uid;

  final snap = fire
      .collection('inApp')
      .doc('employee')
      .collection('info')
      .doc(uid)
      .snapshots();

  final role = snap.map((doc) => RoleModel.fromMap(doc));

  return role;
});

class RoleModel {
  RoleModel({
    required this.role,
    required this.uid,
    required this.email,
  });

  final Role role;
  final String uid;
  final String email;

  factory RoleModel.fromMap(DocumentSnapshot doc) {
    final String role = doc['role'];
    return RoleModel(
      role: role.toRole(),
      uid: doc['uid'],
      email: doc['email'],
    );
  }
}
