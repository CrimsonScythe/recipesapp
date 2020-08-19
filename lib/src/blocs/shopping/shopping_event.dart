import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

abstract class ShoppingEvent extends Equatable {
  const ShoppingEvent();
}

//class FabShowMethod extends ShoppingEvent {
//
//
//
//  @override
//  // TODO: implement props
//  List<Object> get props => throw UnimplementedError();
//
//}

class PopulateDialog extends ShoppingEvent {

  final List<String> keys;
  final String recipeID;

  PopulateDialog(this.keys, this.recipeID);

  @override
  // TODO: implement props
  List<Object> get props => [keys, recipeID];

}

class CreateNewList extends ShoppingEvent{

  final List<String> keys;

  CreateNewList(this.keys);


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

