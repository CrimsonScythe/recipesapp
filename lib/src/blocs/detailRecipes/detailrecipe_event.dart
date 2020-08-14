import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

abstract class DetailRecipeEvent extends Equatable {
  const DetailRecipeEvent();
}

class DetailRecipeRequested extends DetailRecipeEvent {


  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}


class Increment extends DetailRecipeEvent {


  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class Decrement extends DetailRecipeEvent {


  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}


