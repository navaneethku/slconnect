import 'package:cloud_firestore/cloud_firestore.dart';

class LaborerModel {
  final String? id;
  final String age;
  final String location;
  final String name;
  final String role;
  final String phoneNumber;
  final String description;
  final List<String>? skills;

  LaborerModel(
      {this.id,
      required this.age,
      required this.location,
      required this.name,
      required this.role,
      required this.phoneNumber,
      required this.description,
      required this.skills,
      });

  Map<String, dynamic> toMap() {
    return {
      'age': age,
      'location': location,
      'name': name,
      'role': role,
      'phoneNumber': phoneNumber,
      'description': description,
      'skills':skills,
    };
  }

  LaborerModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        age = doc.data()!['age'],
        location = doc.data()!['location'],
        name = doc.data()!['name'],
        role = doc.data()!['role'],
        phoneNumber = doc.data()!['phoneNumber'],
        description = doc.data()!['description'],
        skills = doc.data()?['skills'] == null ? null : doc.data()?['skills'].cast<String>();
}
