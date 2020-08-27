import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:recipes/src/models/shoppinglist.dart';

part 'rootlist.g.dart';

@HiveType(typeId : 0)
class RootList extends Equatable{

//  final String _recipeID;
  @HiveField(0)
  int _docID;
  @HiveField(1)
  final String _ctime;
  @HiveField(2)
  final String _name;
  @HiveField(3)
  final List<ShoppingList> _shplist;

  RootList(this._docID, this._ctime, this._name, this._shplist );

  int get docID => _docID;


  set docID(int value) {
    _docID = value;
  }

  String get ctime => _ctime; //  String get uID => _uID;
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