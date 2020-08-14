import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

abstract class ShoppingEvent extends Equatable {
  const ShoppingEvent();
}


class SelectIngredient extends ShoppingEvent {

  final key;

  SelectIngredient(this.key);


  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class DeselectIngredient extends ShoppingEvent {

  final key;

  DeselectIngredient(this.key);



  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

