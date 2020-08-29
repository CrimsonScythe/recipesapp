import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'favourite.g.dart';

@HiveType(typeId: 2)
class Favourite extends Equatable{

  @HiveField(0)
  int _key;
  @HiveField(1)
  final String _recipeID;
  @HiveField(2)
  final String _ctime;


  Favourite(this._recipeID, this._ctime, this._key) : assert (_recipeID != null);

//  String get uID => _uID;
//  String get _profilePic => _profilePicUrl;



  Favourite.fromJson(Map<String, dynamic> json)
      : _recipeID = json['reciperef'],
        _ctime = json['ctime'],
        _key = json['key'];

  Map<String, dynamic> toJson() =>
      {
        'reciperef' : _recipeID,
        'ctime' : _ctime
      };

//  static const empty = User('', '', null, '');

  @override
  // TODO: implement props
  List<Object> get props => [_recipeID, _ctime ];



  int get key => _key;

  set key(int value) {
    _key = value;
  }

  String get recipeID => _recipeID;
  String get ctime => _ctime;


}