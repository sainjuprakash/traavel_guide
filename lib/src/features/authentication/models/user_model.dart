import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String fullname;
  final String? email;
  final String? phoneNo;
  final String? password;

  const UserModel({
    this.id,
    required this.fullname,
    required this.email,
    required this.phoneNo,
    required this.password,
  });

  toJson() {
    return {
      "Fullname": fullname,
      "Email": email,
      "Phone": phoneNo,
      "Password": password,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      email: data["Email"],
      fullname: data["Fullname"],
      password: data["Password"],
      phoneNo: data["Phone"],
    );
  }
}
