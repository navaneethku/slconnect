import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final Timestamp date;
  final String employerId;
  final String employerPhone;
  final String laborerId;
  final String skill;
  final String workDescription;
  BookingModel({
    required this.employerId,
    required this.employerPhone,
    required this.laborerId,
    required this.skill,
    required this.workDescription,
    required this.date,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      date: json['date'] as Timestamp, employerId: json['employerId'], employerPhone: json['employerPhone'], laborerId: json['laborerId'], skill: json['skill'], workDescription: json['workDescription'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'employerId':employerId,
      'employerPhone':employerId,
      'laborerId':laborerId,
      'skill':skill,
      'workDescription': workDescription,
    };
  }
}
