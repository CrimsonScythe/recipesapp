import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

abstract class ShoppingEvent extends Equatable {
  const ShoppingEvent();
}



//class PopulateDialog extends ShoppingEvent {
//
//  final List<String> keys;
//  final String recipeID;
//
//  PopulateDialog(this.keys, this.recipeID);
//
//  @override
//  // TODO: implement props
//  List<Object> get props => [keys, recipeID];
//
//}

class CreateListDialogState extends ShoppingEvent{

  final List<String> keys;

  CreateListDialogState(this.keys);


  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class ClearList extends ShoppingEvent{




  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}
//class AddIngredientsToList extends ShoppingEvent {
//
//  final List<String> keys;
//  final String recipeID;
//
//  AddIngredientsToList(this.keys, this.recipeID);
//
//  @override
//  // TODO: implement props
//  List<Object> get props => [keys, recipeID];
//
//}

class SelectIngredient extends ShoppingEvent {

  final key;

  SelectIngredient(this.key);


  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class DeselectIngredient extends ShoppingEvent {

  final key;

  DeselectIngredient(this.key);



  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

//class AddToList extends ShoppingEvent {
//
//  final keys;
//  final String listID;
//  final String recipeID;
//
//  AddToList(this.keys, this.listID, this.recipeID);
//
//  @override
//  // TODO: implement props
//  List<Object> get props => throw UnimplementedError();
//
//}

//class CreateListAndAdd extends ShoppingEvent {
//
//  final String name;
//  final List<String> keys;
////  final String listID;
//  final String recipeID;
//
//  CreateListAndAdd(this.name, this.keys, this.recipeID);
//
//
//  @override
//  // TODO: implement props
//  List<Object> get props => [name, keys];
//
//}