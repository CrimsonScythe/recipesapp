import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

abstract class FavouritesState extends Equatable {
  const FavouritesState();
}

class FavouritesInitial extends FavouritesState {

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class FavouritesRetrieved extends FavouritesState {

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class FavouritesFailure extends FavouritesState {

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class FavouriteAdded extends FavouritesState {

//  final FirebaseUser user;
//
//  Authenticated({@required this.user});


  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}


class FavouriteRemoved extends FavouritesState {

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}



