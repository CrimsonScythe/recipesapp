import 'package:equatable/equatable.dart';
import 'package:recipes/src/models/recipe.dart';
import 'package:recipes/src/models/shoppinglist.dart';

abstract class ShoppingListEvent extends Equatable {
  const ShoppingListEvent();
}


class GetRootLists extends ShoppingListEvent {



  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class ParseShoppingLists extends ShoppingListEvent {

  final List<ShoppingList> shplists;

  ParseShoppingLists(this.shplists);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class AddIngredient extends ShoppingListEvent {

  final int key;
  final String ingredient;
  final List<Recipe> recipesList;
  final List<ShoppingList> shplists;


  AddIngredient(this.ingredient, this.key, this.recipesList, this.shplists);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class RemoveIngredient extends ShoppingListEvent {

  final int key;
  final String ingredient;

  RemoveIngredient(this.ingredient, this.key);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class DeleteList extends ShoppingListEvent {

  final int key;

  DeleteList(this.key);


  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class RenameList extends ShoppingListEvent {

  final int key;
  final String name;

  RenameList(this.key, this.name);


  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}