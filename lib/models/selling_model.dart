import 'package:flutter/cupertino.dart';

class Selling {
  Selling({
    String? id,
    String? name,
    String? phoneNumber,
    String? address,
    String? nationalId,
    String? model,
    String? carNumber,
    String? type,
    String? description,
  }) {
    _id = id;
    _name = name;
    _phoneNumber = phoneNumber;
    _address = address;
    _nationalId = nationalId;
    _model = model;
    _carNumber = carNumber;
    _type = type;
    _description = description;
  }

  Selling.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _address = json['address'];
    _phoneNumber = json['phoneNumber'];
    _nationalId = json['nationalId'];
    _model = json['model'];
    _carNumber = json['carNumber'];
    _type = json['type'];
    _description = json['description'];
  }

  String? _id;
  String? _name;
  String? _address;
  String? _phoneNumber;
  String? _nationalId;
  String? _model;
  String? _carNumber;
  String? _type;
  String? _description;

  String? get id => _id;
  String? get name => _name;
  String? get address => _address;
  String? get phoneNumber => _phoneNumber;
  String? get nationalId => _nationalId;
  String? get model => _model;
  String? get carNumber => _carNumber;
  String? get type => _type;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['address'] = _address;
    map['phoneNumber'] = _phoneNumber;
    map['nationalId'] = _nationalId;
    map['model'] = _model;
    map['carNumber'] = _carNumber;
    map['type'] = _type;
    map['description'] = _description;

    return map;
  }
}
