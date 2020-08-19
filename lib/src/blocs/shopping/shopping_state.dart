import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:recipes/src/models/recipe.dart';
import 'package:recipes/src/models/rootlist.dart';

abstract class ShoppingState {
  const ShoppingState();
}

//class ShoppingInitial extends ShoppingState {
//
//}

//class FabShowMethodState extends ShoppingState {
//
//}

class IngredientsState extends ShoppingState {
  final List<String> keys;


  IngredientsState(this.keys);

}

//class IngredientSelected extends ShoppingState {
//
//  final List<String> keys;
//
//  IngredientSelected(this.keys);
//
//}
//
//class IngredientDeselected extends ShoppingState {
//
//  final List<String> keys;
//
//  IngredientDeselected(this.keys);
//
//}




