import 'package:flutter/cupertino.dart';

class Replacing {
  Replacing({
    String? id,
    String? name,
    String? phoneNumber,
    String? address,
    String? nationalId,
    String? job,
    String? salary,
    String? galleryName,
    String? carName,
    String? type,
    String? description,
  }) {
    _id = id;
    _name = name;
    _phoneNumber = phoneNumber;
    _address = address;
    _nationalId = nationalId;
    _job = job;
    _salary = salary;
    _galleryName = galleryName;
    _carName = carName;
    _type = type;
    _description = description;
  }

  Replacing.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _address = json['address'];
    _phoneNumber = json['phoneNumber'];
    _nationalId = json['nationalId'];
    _job = json['job'];
    _salary = json['salary'];
    _galleryName = json['galleryName'];
    _carName = json['carName'];
    _type = json['type'];
    _description = json['description'];
  }

  String? _id;
  String? _name;
  String? _address;
  String? _phoneNumber;
  String? _nationalId;
  String? _job;
  String? _salary;
  String? _galleryName;
  String? _carName;
  String? _type;
  String? _description;

  String? get id => _id;
  String? get name => _name;
  String? get address => _address;
  String? get phoneNumber => _phoneNumber;
  String? get nationalId => _nationalId;
  String? get job => _job;
  String? get salary => _salary;
  String? get galleryName => _galleryName;
  String? get carName => _carName;
  String? get type => _type;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['address'] = _address;
    map['phoneNumber'] = _phoneNumber;
    map['nationalId'] = _nationalId;
    map['job'] = _job;
    map['salary'] = _salary;
    map['galleryName'] = _galleryName;
    map['carName'] = _carName;
    map['type'] = _type;
    map['description'] = _description;

    return map;
  }
}
