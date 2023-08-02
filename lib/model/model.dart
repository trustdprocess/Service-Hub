// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderEmail;
  final String receiveremail;
  final String message;
  final Timestamp timestamp;
  Message({
    required this.senderEmail,
    required this.receiveremail,
    required this.message,
    required this.timestamp,
  });
  Map<String, dynamic> toMap() {
    return {
      'senderEmail': senderEmail,
      'receiveremail': receiveremail,
      'message': message,
      'timestamp': timestamp
    };
  }
}
