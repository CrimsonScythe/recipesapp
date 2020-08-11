import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

abstract class FavouritesEvent extends Equatable {
  const FavouritesEvent();
}


class RemoveFavourite extends FavouritesEvent {

  final recipeID;

  RemoveFavourite(this.recipeID);


  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class AddFavourite extends FavouritesEvent {

  final recipeID;

  AddFavourite(this.recipeID);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();



}

class GetFavourites extends FavouritesEvent {

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}


