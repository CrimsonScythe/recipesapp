import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'shoppinglist.g.dart';

@HiveType(typeId : 1)
class ShoppingList extends Equatable{

  @HiveField(0)
  final String _recipeID;
  @HiveField(1)
  final String _ctime;
  @HiveField(2)
  final List<dynamic> _ingList;

  const ShoppingList(this._recipeID, this._ctime,this._ingList ) : assert (_recipeID != null);

  String get recipeID => _recipeID; //  String get uID => _uID;
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

  String get ctime => _ctime;

  List<dynamic> get ingList => _ingList;

//  static const empty = ShoppingList('', Timestamp.now(), null);

}