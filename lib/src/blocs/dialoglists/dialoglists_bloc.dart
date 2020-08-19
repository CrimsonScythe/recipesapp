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

      final lists = await _repository.getShoppingLists(_repository.user.uID);

      if (lists != null && lists.length!=0) {

        yield ShoppingListExists(lists);

      } else {
        yield ShoppingListNotExists();

      }

    }

    if (event is CreateListAndAdd) {

      final listid = await _repository.createShoppingList(_repository.user.uID, event.name);
      _repository.addtoShoppingList(_repository.user.uID, event.keys, listid, event.recipeID);

      yield AddedToList();

    }

  }


}
