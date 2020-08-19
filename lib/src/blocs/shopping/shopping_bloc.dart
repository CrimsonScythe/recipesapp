import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/resources/repository.dart';
import 'package:recipes/src/blocs/shopping/shopping_event.dart';
import 'package:recipes/src/blocs/shopping/shopping_state.dart';
import 'package:recipes/src/models/rootlist.dart';

class ShoppingBloc extends Bloc<ShoppingEvent, ShoppingState> {
  // todo check initial state
  ShoppingBloc() : super(IngredientsState(new List<String>(), new List<RootList>(), false));

  Repository _repository = Repository();

  @override
  Stream<ShoppingState> mapEventToState(ShoppingEvent event) async* {

    if (event is SelectIngredient) {
      /// here we must append ingredient to list
//      final ingredientList = _repository.addIngredient(event.key);
//      print(ingredientList);
//      yield IngredientsState(ingredientList);
//      if (state is IngredientsState){
        final lst = (state as IngredientsState).keys;
        lst.add(event.key);
        print(lst);
        yield IngredientsState(lst, new List<RootList>(), false);
//      } else {
//        var lst=new List<String>();
//        lst.add(event.key);
//        yield IngredientsState(lst);
//      }

    }

    if (event is DeselectIngredient) {
//      final ingredientList = _repository.removeIngredient(event.key);
//      print(ingredientList);
//      yield IngredientsState(ingredientList);
      final lst = (state as IngredientsState).keys;
      lst.remove(event.key);
      print(lst);
      yield IngredientsState(lst, new List<RootList>(), false);
    }

    if (event is PopulateDialog){
      /// add to repo or something
      /// show pop-up
      /// if list does not exist then create prompt
      /// otherwise display all lists and option to create new one
      // todo add to repo or something

//      final rootlists = await _repository.getShoppingLists(_repository.user.uID);
//      _repository.createShoppingList(uID, name)
//      rootlists[0].

    final lists = await _repository.getShoppingLists(_repository.user.uID);



    if (lists != null) {
      yield IngredientsState(event.keys, new List<RootList>(), true);

      if (lists.length!=0){

      } else {
        yield IngredientsState(event.keys, lists, false);
      }

    } else {
      yield IngredientsState(event.keys, new List<RootList>(), true);
//      final listID = await _repository.createShoppingList(_repository.user.uID, 'list1');
//      await _repository.addtoShoppingList(_repository.user.uID, event.keys, listID, event.recipeID);
//      yield IngredientsState(new List<String>());
    }





    }

    if (event is CreateNewList) {
      yield IngredientsState(event.keys, new List<RootList>(), true);
    }

    if (event is ClearList) {
      yield IngredientsState(new List<String>(), new List<RootList>(), false);
    }



  }

}