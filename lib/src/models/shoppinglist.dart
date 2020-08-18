import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ShoppingList extends Equatable{

  final String _recipeID;
  final Timestamp _ctime;
  final List<String> _ingList;

  const ShoppingList(this._recipeID, this._ctime,this._ingList ) : assert (_recipeID != null);

//  String get uID => _uID;
//  String get _profilePic => _profilePicUrl;



  ShoppingList.fromJson(Map<String, dynamic> json)
      : _recipeID = json['reciperef'],
        _ctime = json['ctime'],
          _ingList = json['inglist'];

  Map<String, dynamic> toJson() =>
      {
        'reciperef' : _recipeID,
        'ctime' : _ctime,
        'inglist' : _ingList
      };

//  static const empty = User('', '', null, '');

  @override
  // TODO: implement props
  List<Object> get props => [_recipeID, _ctime, _ingList];


}