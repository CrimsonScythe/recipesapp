import 'package:recipes/src/models/rootlist.dart';
//todo: Equatable?
abstract class DialogListsState {
  const DialogListsState();
}



class ShoppingListExists extends DialogListsState {

  final List<RootList> rootLists;
  final String docID;

  ShoppingListExists(this.rootLists, this.docID);

}


class ShoppingListNotExists extends DialogListsState {

//  final List<RootList> rootLists;
//
//  ShoppingListNotExists(this.rootLists);

}

class LoadingLists extends DialogListsState {

}

class AddedToList extends DialogListsState {

}

class DialogStateInitial extends DialogListsState {

}



