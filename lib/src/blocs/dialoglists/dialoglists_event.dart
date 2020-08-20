import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:recipes/src/models/rootlist.dart';

abstract class DialogListsEvent extends Equatable {
  const DialogListsEvent();
}



class FetchShoppingLists extends DialogListsEvent {


  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class CreateListAndAdd extends DialogListsEvent {


  final List<String> keys;
  final String recipeID;
  final String name;

  CreateListAndAdd(this.name, this.keys, this.recipeID);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class CreateListDialogEvent extends DialogListsEvent {

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class onChanged extends DialogListsEvent {

  final List<RootList> rootLists;
  final String value;

  onChanged( this.rootLists, this.value,);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class AddToList extends DialogListsEvent {


  final List<String> keys;
  final String recipeID;
  final String listID;

  AddToList(this.keys, this.listID, this.recipeID);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}
