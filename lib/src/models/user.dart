import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable{

  final String _uID;
  final String _name;
  final Timestamp _ctime;
  final String _profilePicUrl;


  const User(this._uID, this._name, this._ctime, this._profilePicUrl) : assert (_uID != null);

  String get uID => _uID;
  String get _profilePic => _profilePicUrl;

  User.fromJson(Map<String, dynamic> json)
      : _uID = json['uID'],
        _name = json['name'],
        _ctime = json['ctime'],
        _profilePicUrl = json['profilepicurl'];

  Map<String, dynamic> toJson() =>
      {
        'uID' : _uID,
        'name' : _name,
        'ctime' : _ctime,
        'profilepicurl' : _profilePicUrl,
      };

  static const empty = User('', '', null, '');

  @override
  // TODO: implement props
  List<Object> get props => [_uID, _name, _ctime, _profilePicUrl];


}