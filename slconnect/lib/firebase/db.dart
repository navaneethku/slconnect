import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:slconnect/app/models/BookingModel.dart';
import 'package:slconnect/app/models/EmployerModel.dart';
import 'package:slconnect/app/models/LaborerModel.dart';

import '../consts/common_instances.dart';

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

  addLaborer(LaborerModel laborerData) async {
    await _db
        .collection("users")
        .doc(currentUser!.uid)
        .set(laborerData.toMap());
    final availability = <String,bool>{
    "availability":true,
    };
    await _db.collection("availability").doc(currentUser!.uid).set(availability);
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
  //TODO
  Future<LaborerModel?> getLaborerById() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _db.collection('users').doc(currentUser!.uid).get();
    if (snapshot.exists) {
      final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      final LaborerModel laborer = LaborerModel(
        name: data['name'],
        age: data['age'],
        location: data['location'],
        role: data['role'],
        phoneNumber: data['phoneNumber'],
         description: data['description'], 
         skills: [],
      );
      return laborer;
    } else {
      return null;
    }
  }

  Future<List<LaborerModel?>> getAllLaborers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("users").where('role', isEqualTo: 'laborer').get();
    return snapshot.docs
        .map((docSnapshot) => LaborerModel.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<LaborerModel?>> getLaborersByCategory(String skill) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection("users")
        .where('role', isEqualTo: 'laborer')
        .where('skills', arrayContains: skill)
        .get();
    return snapshot.docs
        .map((docSnapshot) => LaborerModel.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
   static Future<BookingModel?> fetchBooking(String bookingId) async {
    final snapshot =
        await FirebaseFirestore.instance.collection('bookings').doc(bookingId).get();

    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      return BookingModel.fromJson(data);
    }

    return null;
  }

  static Future<void> deleteBooking(String bookingId) async {
    await FirebaseFirestore.instance.collection('bookings').doc(bookingId).delete();
  }
}
