import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class BottomNavState extends Equatable {
  const BottomNavState();
}

class CurrentIndexChanged extends BottomNavState {

  final int currentIndex;

  CurrentIndexChanged({@required this.currentIndex});


  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class PageLoading extends BottomNavState {

  @override
  String toString() => 'PageLoading';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class HomePageLoaded extends BottomNavState {



  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class FavouritesPageLoaded extends BottomNavState {



  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

