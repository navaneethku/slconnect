import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    final availability = <String, bool>{
      "availability": true,
    };
    await _db
        .collection("availability")
        .doc(currentUser!.uid)
        .set(availability);
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

  Future<EmployerModel?> getEmployer() async {
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

  Future<EmployerModel?> getEmployerById(String employerId) async {
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
        skills: data["skills"].cast<String>(),
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
    CollectionReference availabilityCollection =
        FirebaseFirestore.instance.collection("availability");
    QuerySnapshot availabilitySnapshot = await availabilityCollection
        .where('availability', isEqualTo: true)
        .get();
    List<String> laborerIds =
        availabilitySnapshot.docs.map((doc) => doc.id).toList();
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection("users")
        .where('role', isEqualTo: 'laborer')
        .where('skills', arrayContains: skill)
        .where(FieldPath.documentId, whereIn: laborerIds)
        .get();
    return snapshot.docs
        .map((docSnapshot) => LaborerModel.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  static Future addNotification(BookingModel bookingModel) async {
    var bookingReference =
        await _db.collection("notifications").add(bookingModel.toJson());
    debugPrint("addNotificationsSuccessfull");
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('notifications');
    DocumentReference docRef = collectionRef.doc(bookingReference.id);
    docRef.update({
      'id': bookingReference.id,
    });
  }

  static Future addToMyBookingAndRemoveFromNotifications(
      BookingModel bookingModel) async {
    var bookingReference =
        await _db.collection("bookings").add(bookingModel.toJson());
    debugPrint("addBookingSuccessfull");
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("notifications");
    DocumentReference docRef = collectionRef.doc(bookingModel.id);
    docRef.delete();
    debugPrint("deleteSuccessfull");
  }
  static Future removeFromNotifications(
      BookingModel bookingModel) async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("notifications");
    DocumentReference docRef = collectionRef.doc(bookingModel.id);
    docRef.delete();
    debugPrint("deleteSuccessfull");
  }

  static Future<List<BookingModel>> fetchBookingLaborer() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('bookings')
        .where("laborerId", isEqualTo: currentUser!.uid)
        .get();

    List<BookingModel> bookingList = [];
    snapshot.docs.forEach((doc) {
      BookingModel booking = BookingModel.fromJson(doc.data());
      bookingList.add(booking);
    });
    return bookingList;
  }

  Stream<List<BookingModel>> fetchBookingLaborerStream() {
    return FirebaseFirestore.instance
        .collection('notifications')
        .where("laborerId", isEqualTo: currentUser!.uid)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return BookingModel.fromJson(doc.data());
            }).toList());
  }

  Stream<List<BookingModel>> fetchBookingLaborerForBookingPageStream() {
    return FirebaseFirestore.instance
        .collection('bookings')
        .where("laborerId", isEqualTo: currentUser!.uid)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return BookingModel.fromJson(doc.data());
            }).toList());
  }

  static Future<List<BookingModel>> fetchBookingEmployer() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('bookings')
        .where("employerId", isEqualTo: currentUser!.uid)
        .get();

    List<BookingModel> bookingList = [];
    snapshot.docs.forEach((doc) {
      BookingModel booking = BookingModel.fromJson(doc.data());
      bookingList.add(booking);
    });
    return bookingList;
  }

  static Future<List<BookingModel>> fetchBookingEmployerforBookingPage() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('bookings')
        .where("employerId", isEqualTo: currentUser!.uid)
        .get();

    List<BookingModel> bookingList = [];
    snapshot.docs.forEach((doc) {
      BookingModel booking = BookingModel.fromJson(doc.data());
      bookingList.add(booking);
    });
    return bookingList;
  }

  static Future<void> deleteBooking(String bookingId) async {
    await FirebaseFirestore.instance
        .collection('bookings')
        .doc(bookingId)
        .delete();
  }
}
