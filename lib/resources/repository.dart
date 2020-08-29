
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:recipes/resources/data_provider.dart';
import 'package:recipes/resources/firestore_provider.dart';
import 'package:recipes/src/blocs/favourites/favourites_event.dart';
import 'package:recipes/src/models/favourite.dart';
import 'package:recipes/src/models/ingredients.dart';
import 'package:recipes/src/models/recipe.dart';
import 'package:recipes/src/models/rootlist.dart';
import 'package:recipes/src/models/shoppinglist.dart';
import 'package:recipes/src/models/user.dart';
import 'package:tuple/tuple.dart';

class Repository {
  static final Repository _repository = Repository._internal();

  final _firestoreProvider = FirestoreProvider();
  final _dataProvider = DataProvider();

  User user;
  List<String> favouritesList;
  List<String> ingredients = new List<String>();
  List<Ingredients> ingredientsList = new List<Ingredients>();

  factory Repository() {
    return _repository;
  }

  Repository._internal();

  loadIngredients() async {

    String jsonString = await rootBundle.loadString('assets/ingredients.json');
    Map ingMap = jsonDecode(jsonString);
    var count = ingMap['tags'] as List;
    for (int i =0; i<count.length; i++){
      ingredientsList.add(Ingredients.fromJson(count[i]));
    }

  }

  List<String> filterIngredients(List<ShoppingList> shplists) {

    final set = Set<String>();

    shplists.forEach((element) {
      set.addAll(List<String>.from(element.ingList));
    });

    return set.toList();

  }

  List<String> addIngredient(ingredient) {
    ingredients.add(ingredient);
    return ingredients;
  }

  List<String> removeIngredient(ingredient) {
    ingredients.remove(ingredient);
    return ingredients;
  }

  Future<List<Recipe>> getRecipesList(List<ShoppingList> shplists) =>
    _firestoreProvider.getRecipesList(shplists);


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

  void deleteShoppingListLocal(key) =>
  _dataProvider.deleteShoppingListLocal(key);

  void renameShoppingListLocal(key, name) =>
  _dataProvider.renameShoppingListLocal(key, name);

  /// add to existing shopping list
//  Future<void> addtoShoppingList(uID, list, listID, recipeID) =>
//  _firestoreProvider.addtoShoppingList(uID, listID, recipeID, list);

  /// get all master/root lists
//  Future<List<RootList>> getShoppingLists(uID) =>
//  _firestoreProvider.getShoppingLists(uID);

  Future<void> addToShoppingListLocal(recipeID, key, list) =>
  _dataProvider.addToShoppingListLocal(recipeID, key, list);

  Future<int> createShoppingListLocal(name) =>
  _dataProvider.createShoppingListLocal(name);

  Future<List<RootList>> getShoppingListsLocal() =>
  _dataProvider.getShoppingListsLocal();

  Future<List<ShoppingList>> getShoppingListsLocalFromRoot(rootKey) =>
  _dataProvider.getShoppingListsLocalFromRoot(rootKey);

  /// create new root shopping list
//  Future<String> createShoppingList(uID, name) =>
//  _firestoreProvider.createShoppingList(uID, name);


  /// to db
//  Future<void> addFavourite(uID, recipeID) =>
//     _firestoreProvider.setFavourite(uID, recipeID);


  /// to shared pref
  Future<void> setFavourite(recipeID) async {
    await _dataProvider.setFavourite(recipeID);
    _repository.favouritesList = await _repository.getFavouritesSharedPref();
//    _repository.favouritesList=;
  }
  Future<bool> deleteFavourites(recipeID) async {
      final bol = await _dataProvider.deleteFavourites(recipeID);
//      _repository.favouritesList=;
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

  Future<void> setFavouritesToHive(favList) =>
  _dataProvider.setFavouritesToHive(favList);

  Future<List<String>> addFavouriteLocal(recipeID) =>
  _dataProvider.addFavourite(recipeID);

  Future<List<String>> removeFavouriteLocal(recipeID) =>
  _dataProvider.deleteFavourite(recipeID);

  Future<List<Favourite>> getFavouritesFirebase(userID) =>
  _firestoreProvider.getFavouritesFirebase(userID);

  Future<List<Favourite>> getFavouritesLocalHive() =>
  _dataProvider.getFavoritesLocal();

  Future<List<Recipe>> getFavouritesLocal() =>
  _dataProvider.getFavourites();

  Future<List<String>> getStringFavourites() =>
  _dataProvider.getStringFavourites();

  Future<void> removeIngredientLocal(key, ing) =>
  _dataProvider.deleteIngredient(key, ing);


  Future<void> setFavouritesToFirebase(favList, userID) =>
  _firestoreProvider.setFavouritesToFirebase(favList, userID);

  Future<void> addIngredientLocal(key, ing) =>
  _dataProvider.addIngredient(key, ing);

  Future<User> logInAnon() =>
      _firestoreProvider.logInAnon();

  Future<User> logInWithGoogle() =>
      _firestoreProvider.logInWithGoogle();

  Future<User> logInWithFacebook() =>
      _firestoreProvider.logInWithFacebook();

  Future<void> logOut() =>
      _firestoreProvider.logOut();



}