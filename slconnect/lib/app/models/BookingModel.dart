import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  String? id;
  final String employerId;
  final String employerPhone;
  final Timestamp endDate;
  final String laborerId;
  final String skill;
  final Timestamp startDate;
  final String workDescription;
  final double price;
  BookingModel({
    this.id,
    required this.employerId,
    required this.employerPhone,
    required this.endDate,
    required this.laborerId,
    required this.startDate,
    required this.skill,
    required this.workDescription,
    required this.price,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      employerId: json['employerId'],
      employerPhone: json['employerPhone'],
      laborerId: json['laborerId'],
      skill: json['skill'],
      workDescription: json['workDescription'],
      endDate: json['endDate'] as Timestamp,
      startDate: json['startDate'] as Timestamp,
      price: json['price'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate,
      'endDate': endDate,
      'employerId': employerId,
      'employerPhone': employerId,
      'laborerId': laborerId,
      'skill': skill,
      'workDescription': workDescription,
      'price': price,
    };
  }
}
