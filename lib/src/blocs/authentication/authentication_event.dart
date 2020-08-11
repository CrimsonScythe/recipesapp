import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class LogInRequestedAnon extends AuthenticationEvent {

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class LogOutRequested extends AuthenticationEvent {

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

