import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:recipes/src/models/shoppinglist.dart';

class RootList extends Equatable{

//  final String _recipeID;
  final Timestamp _ctime;
  final String _name;
  final List<ShoppingList> _shplist;

  const RootList(this._ctime, this._name, this._shplist );


  Timestamp get ctime => _ctime; //  String get uID => _uID;
//  String get _profilePic => _profilePicUrl;



//  RootList.fromJson(Map<String, dynamic> json)
//      : _ctime = json['ctime'],
//        _ctime = json['ctime'],
//        _ingList = json['inglist'];

//  Map<String, dynamic> toJson() =>
//      {
//        'reciperef' : _recipeID,
//        'ctime' : _ctime,
//        'inglist' : _ingList
//      };

//  static const empty = User('', '', null, '');

  @override
  // TODO: implement props
  List<Object> get props => [_ctime, _name, _shplist];

  String get name => _name;

  List<ShoppingList> get shplist => _shplist;


}