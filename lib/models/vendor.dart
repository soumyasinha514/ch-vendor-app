import 'package:uuid/uuid.dart';
import 'dart:io';

var uuid = Uuid();

class Vendor {
  String name;
  String id;
  String workshop_name;
  String location;
  File? profilePhoto;

  Vendor({
    required this.name,
    required this.workshop_name,
    required this.location,
   
    this.profilePhoto,
  }) : id = uuid.v4().substring(0,8);

  Vendor copyWith({String? name,  File? profilePhoto, String? workshop_name,String?location}) {
    return Vendor(
        name: name ?? this.name,
        profilePhoto: profilePhoto ?? this.profilePhoto,
        workshop_name:  workshop_name ?? this.workshop_name,
        location: location ?? this.location
        );
  }
}
