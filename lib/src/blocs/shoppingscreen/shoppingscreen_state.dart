import 'package:equatable/equatable.dart';
import 'package:recipes/src/models/rootlist.dart';

abstract class ShoppingScreenState extends Equatable {
  const ShoppingScreenState();
}

class ShoppingStateInitial extends ShoppingScreenState {

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class RootListsNotExist extends ShoppingScreenState {

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class RootListsExist extends ShoppingScreenState {

  final List<RootList> rootLists;

  RootListsExist(this.rootLists);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}