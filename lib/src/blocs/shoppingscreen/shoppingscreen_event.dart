import 'package:equatable/equatable.dart';

abstract class ShoppingScreenEvent extends Equatable {
  const ShoppingScreenEvent();
}

class RefreshLists extends ShoppingScreenEvent{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class GetRootLists extends ShoppingScreenEvent {



  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}