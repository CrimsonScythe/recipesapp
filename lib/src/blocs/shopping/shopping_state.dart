import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:recipes/src/models/recipe.dart';

abstract class ShoppingState extends Equatable {
  const ShoppingState();
}

class ShoppingInitial extends ShoppingState {

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class IngredientSelected extends ShoppingState {

//  final key;
  final List<String> keys;

  IngredientSelected(this.keys);

  @override
  // TODO: implement props
  List<Object> get props => [this.keys];

}

class IngredientDeselected extends ShoppingState {

//  final key;
  final List<String> keys;

  IngredientDeselected(this.keys);

  @override
  // TODO: implement props
  List<Object> get props => [this.keys];

}


//class FavouritesRetrieved extends ShoppingState {
//
//  final List<Recipe> favList;
//
//  FavouritesRetrieved(this.favList);
//
//  @override
//  // TODO: implement props
//  List<Object> get props => throw UnimplementedError();
//
//}




