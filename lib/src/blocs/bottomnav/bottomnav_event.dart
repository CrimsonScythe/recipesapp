import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

abstract class BottomNavEvent extends Equatable {
  const BottomNavEvent();
}

class PageTapped extends BottomNavEvent {

  final int index;

  PageTapped({@required this.index});


  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}