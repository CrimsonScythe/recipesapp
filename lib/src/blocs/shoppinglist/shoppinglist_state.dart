import 'package:equatable/equatable.dart';
import 'package:recipes/src/models/recipe.dart';
import 'package:recipes/src/models/rootlist.dart';

abstract class ShoppingListState extends Equatable {
  const ShoppingListState();
}

class ShoppingListStateInitial extends ShoppingListState {

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