import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

abstract class TextFormEvent extends Equatable {
  const TextFormEvent();
}


class NameChanged extends TextFormEvent {

  final String name;

  NameChanged(this.name);

  @override
  // TODO: implement props
  List<Object> get props => [name];

}

class SubmitName extends TextFormEvent {

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}
