import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slconnect/app/models/EmployerModel.dart';

import '../consts/firebase_consts.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

class DatabaseService {
  String? getCurrentUser() {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      return currentUser!.uid;
    } else {
      return null;
    }
  }

  addEmployer(EmployerModel employerData) async {
    await _db
        .collection("users")
        .doc(currentUser!.uid)
        .set(employerData.toMap());
  }

  updateEmployer(EmployerModel employerData) async {
    await _db
        .collection("users")
        .doc(currentUser!.uid)
        .update(employerData.toMap());
  }

  Future<List> getAllEmployers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection("users")
        .where('role', isEqualTo: 'employer')
        .get();
    return snapshot.docs
        .map((docSnapshot) => EmployerModel.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<EmployerModel?> getEmployerById() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _db.collection('users').doc(currentUser!.uid).get();
    if (snapshot.exists) {
      final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      final EmployerModel employer = EmployerModel(
        name: data['name'],
        age: data['age'],
        location: data['location'],
        role: data['role'],
        phoneNumber: data['phoneNumber'],
      );
      return employer;
    } else {
      return null;
    }
  }
}
