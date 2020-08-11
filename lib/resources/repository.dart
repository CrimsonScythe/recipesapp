
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipes/resources/data_provider.dart';
import 'package:recipes/resources/firestore_provider.dart';
import 'package:recipes/src/models/recipe.dart';
import 'package:recipes/src/models/user.dart';

class Repository {
  static final Repository _repository = Repository._internal();

  final _firestoreProvider = FirestoreProvider();
  final _dataProvider = DataProvider();

  User user;



  factory Repository() {
    return _repository;
  }

  Repository._internal();

  Future<QuerySnapshot> getDailyRecipes() =>
      _firestoreProvider.getDailyRecipes();

  Future<String> setDailyRecipes(recipeSnapshots) =>
  _dataProvider.setDailyRecipes(recipeSnapshots);

  Future<List<Recipe>> readDailyRecipes(localpath) =>
      _dataProvider.readDailyRecipes(localpath);

  Future<FirebaseUser> getUser() =>
      _firestoreProvider.getUser();

  Future<void> addUser(user) =>
    _firestoreProvider.addUser(user);

  Future<void> addFavourite(uID, recipeID) {
    _firestoreProvider.setFavourite(uID, recipeID);
  }


  Future<void> removeFavourite(uID, recipeID) =>
  _firestoreProvider.deleteFavourite(uID, recipeID);

  Future<List<Recipe>> getFavourites(uID) =>
  _firestoreProvider.getFavourites(uID);



  Future<User> logInAnon() =>
      _firestoreProvider.logInAnon();

  Future<User> logInWithGoogle() =>
      _firestoreProvider.logInWithGoogle();

  Future<User> logInWithFacebook() =>
      _firestoreProvider.logInWithFacebook();

  Future<void> logOut() =>
      _firestoreProvider.logOut();



}