import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Favourite extends Equatable{

  final String _recipeID;
  final Timestamp _ctime;


  const Favourite(this._recipeID, this._ctime) : assert (_recipeID != null);

//  String get uID => _uID;
//  String get _profilePic => _profilePicUrl;

  Favourite.fromJson(Map<String, dynamic> json)
      : _recipeID = json['reciperef'],
        _ctime = json['ctime'];

  Map<String, dynamic> toJson() =>
      {
        'reciperef' : _recipeID,
        'ctime' : _ctime
      };

//  static const empty = User('', '', null, '');

  @override
  // TODO: implement props
  List<Object> get props => [_recipeID, _ctime ];


}