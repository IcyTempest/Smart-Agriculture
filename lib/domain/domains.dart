import 'package:firebase_auth/firebase_auth.dart';

class MyContent {
  MyContent({
    this.imagePath,
    this.date,
    this.devices,
    this.farmerName,
    this.local,
    this.title,
  });

  String? imagePath;
  String? title;
  String? farmerName;
  double? local;
  int? devices;
  String? date;
}

class MyUser {
  MyUser({this.name, this.id, this.phoneNumber, this.pic});

  String? id;
  String? name;
  String? phoneNumber;
  String? pic;
}

/// Firebase User
class FUser {
  String? uid;
  String? phone;

  FUser({this.uid, this.phone});
}
