import 'package:cloud_firestore/cloud_firestore.dart';

class EmployerModel {
  final String? id;
  final String age;
  final String location;
  final String name;
  final String role;
  final String phoneNumber;

  EmployerModel({
    this.id,
    required this.age,
    required this.location,
    required this.name,
    required this.role,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'age': age,
      'location': location,
      'name': name,
      'roll': role,
      'phoneNumber':phoneNumber,
    };
  }

  EmployerModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        age = doc.data()!['age'],
        location = doc.data()!['location'],
        name = doc.data()!['name'],
        role = doc.data()!['role'],
        phoneNumber = doc.data()!['phoneNumber'];
}
