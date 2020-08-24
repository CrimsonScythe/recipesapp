import 'package:equatable/equatable.dart';
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

class RemoveIngredient extends ShoppingListEvent {

  final int key;
  final String ingredient;

  RemoveIngredient(this.ingredient, this.key);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}