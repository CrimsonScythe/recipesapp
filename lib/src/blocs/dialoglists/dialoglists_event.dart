import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

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
