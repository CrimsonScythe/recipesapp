import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/resources/repository.dart';
import 'package:recipes/src/blocs/dialoglists/dialoglists_event.dart';
import 'package:recipes/src/blocs/dialoglists/dialoglists_state.dart';

class DialogListsBloc extends Bloc<DialogListsEvent, DialogListsState> {
  DialogListsBloc() : super(DialogStateInitial());

  Repository _repository = Repository();

  @override
  Stream<DialogListsState> mapEventToState(DialogListsEvent event) async* {

    if (event is FetchShoppingLists) {

      yield LoadingLists();

      // todo changing from firestore to local db
//      final lists = await _repository.getShoppingLists(_repository.user.uID);
      final lists = await _repository.getShoppingListsLocal();


      if (lists != null && lists.length!=0) {

        yield ShoppingListExists(lists, lists[0].docID);

      } else {
        yield ShoppingListNotExists();

      }

    }

    if (event is CreateListAndAddLocal) {

      final key = await _repository.createShoppingListLocal(event.name);
      await _repository.addToShoppingListLocal(event.recipeID, key, event.keys);

      yield AddedToList();

    }

    if (event is CreateList) {
      await _repository.createShoppingListLocal(event.name);
//      yield AddedToList();
    }

//    if (event is CreateListAndAdd) {
//
//      final listid = await _repository.createShoppingList(_repository.user.uID, event.name);
//      await _repository.addtoShoppingList(_repository.user.uID, event.keys, listid, event.recipeID);
//
//      yield AddedToList();
//
//    }


//    if (event is AddToList) {
//      await _repository.addtoShoppingList(_repository.user.uID, event.keys, event.listID, event.recipeID);
//      yield AddedToList();
//    }

    if (event is AddToListLocal) {
//      await _repository.addtoShoppingList(_repository.user.uID, event.keys, event.listID, event.recipeID);
      await _repository.addToShoppingListLocal(event.recipeID, event.key, event.keys);
      yield AddedToList();
    }

    if (event is onChanged) {
      yield ShoppingListExists(event.rootLists, event.value);
    }

    if (event is CreateListDialogEvent) {
      yield ShoppingListNotExists();
    }

  }


}
