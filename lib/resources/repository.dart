
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
  List<String> favouritesList;
  List<String> ingredients = new List<String>();

  factory Repository() {
    return _repository;
  }

  Repository._internal();

  List<String> addIngredient(ingredient) {
    ingredients.add(ingredient);
    return ingredients;
  }

  List<String> removeIngredient(ingredient) {
    ingredients.remove(ingredient);
    return ingredients;
  }


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

  /// to db
  Future<void> addFavourite(uID, recipeID) =>
     _firestoreProvider.setFavourite(uID, recipeID);


  /// to shared pref
  Future<void> setFavourite(recipeID) async {
    await _dataProvider.setFavourite(recipeID);
    _repository.favouritesList = await _repository.getFavouritesSharedPref();
  }
  Future<bool> deleteFavourite(recipeID) async {
      final bol = await _dataProvider.deleteFavourite(recipeID);
      _repository.favouritesList = await _repository.getFavouritesSharedPref();
      return bol;
  }
  /// check if favourite exists
  Future<bool> existFavourite(recipeID) =>
    _dataProvider.existFavourite(recipeID);

  Future<List<String>> getFavouritesSharedPref() =>
  _dataProvider.getFavouritesSharedPref();

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