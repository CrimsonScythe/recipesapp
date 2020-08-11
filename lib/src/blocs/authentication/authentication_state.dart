import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class Authenticated extends AuthenticationState {

//  final FirebaseUser user;
//
//  Authenticated({@required this.user});


  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class Unknown extends AuthenticationState {

  @override
  String toString() => 'PageLoading';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class UnAuthenticated extends AuthenticationState {

  @override
  String toString() => 'PageLoading';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class AuthenticationError extends AuthenticationState {

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}



