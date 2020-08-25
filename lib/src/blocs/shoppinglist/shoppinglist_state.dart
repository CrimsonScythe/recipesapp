import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recipes/src/models/ingredients.dart';
import 'package:recipes/src/models/recipe.dart';
import 'package:recipes/src/models/rootlist.dart';

abstract class ShoppingListState{
  const ShoppingListState();
}

class ShoppingListStateInitial extends ShoppingListState {
//
//  final GlobalKey<AutoCompleteTextFieldState<Ingredients>> key;
//
//  ShoppingListStateInitial(this.key);



  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class RecipesListLoaded extends ShoppingListState {

  final List<Recipe> recipesList;
  final List<String> ingList;

  RecipesListLoaded(this.recipesList, this.ingList);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}
//
//class RootListsNotExist extends ShoppingScreenState {
//
//  @override
//  // TODO: implement props
//  List<Object> get props => throw UnimplementedError();
//
//}
//
//class RootListsExist extends ShoppingScreenState {
//
//  final List<RootList> rootLists;
//
//  RootListsExist(this.rootLists);
//
//  @override
//  // TODO: implement props
//  List<Object> get props => throw UnimplementedError();
//
//}