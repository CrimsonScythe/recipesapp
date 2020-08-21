import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/resources/repository.dart';
import 'package:recipes/src/blocs/shoppinglist/shoppinglist_event.dart';
import 'package:recipes/src/blocs/shoppinglist/shoppinglist_state.dart';
import 'package:recipes/src/models/recipe.dart';
import 'package:recipes/src/models/rootlist.dart';

class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState> {
  ShoppingListBloc() : super(ShoppingListStateInitial());

  Repository _repository = Repository();

  @override
  Stream<ShoppingListState> mapEventToState(ShoppingListEvent event) async* {
    if (event is ParseShoppingLists) {

//      event.shplists

      final List<Recipe> recipesList = await _repository.getRecipesList(event.shplists);

      yield RecipesListLoaded(recipesList);

    }



  }

}