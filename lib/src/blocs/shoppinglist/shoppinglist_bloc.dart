import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/resources/repository.dart';
import 'package:recipes/src/blocs/shoppinglist/shoppinglist_event.dart';
import 'package:recipes/src/blocs/shoppinglist/shoppinglist_state.dart';
import 'package:recipes/src/models/ingredients.dart';
import 'package:recipes/src/models/recipe.dart';
import 'package:recipes/src/models/rootlist.dart';
import 'package:tuple/tuple.dart';

class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState> {
  ShoppingListBloc() : super(ShoppingListStateInitial());

  Repository _repository = Repository();

  @override
  Stream<ShoppingListState> mapEventToState(ShoppingListEvent event) async* {
    if (event is ParseShoppingLists) {

//      event.shplists

      final List<Recipe> recipesList = await _repository.getRecipesList(event.shplists);
      final List<Tuple2<dynamic,dynamic>> ingList = _repository.filterIngredients(event.shplists);

      yield RecipesListLoaded(recipesList, ingList);

    }

    if (event is RemoveIngredient) {

      _repository.removeIngredientLocal(event.key, event.ingredient);

      /// must do this to get updated root
      final shplists = await _repository.getShoppingListsLocalFromRoot(event.key);
      final List<Tuple2<dynamic,dynamic>> ingList = _repository.filterIngredients(shplists);
      final List<Recipe> recipesList = await _repository.getRecipesList(shplists);


      yield RecipesListLoaded(recipesList, ingList);

    }

    if (event is AddIngredient) {
      _repository.addIngredientLocal(event.key, event.ingredient);

//      final List<Recipe> recipesList = await _repository.getRecipesList(event.shplists);

      /// must do this to get updated root
      final shplists = await _repository.getShoppingListsLocalFromRoot(event.key);
      final List<Tuple2<dynamic,dynamic>> ingList = _repository.filterIngredients(shplists);


      yield RecipesListLoaded(event.recipesList, ingList);
    }

    if (event is DeleteList) {
      _repository.deleteShoppingListLocal(event.key);
    }

    if (event is RenameList) {
      _repository.renameShoppingListLocal(event.key, event.name);
    }

  }

}