
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipes/resources/data_provider.dart';
import 'package:recipes/resources/firestore_provider.dart';
import 'package:recipes/src/models/recipe.dart';

class Repository {
  static final Repository _repository = Repository._internal();

  final _firestoreProvider = FirestoreProvider();
  final _dataProvider = DataProvider();

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


//  void getRecipeImg(urls) =>
//      _dataProvider.getRecipeImg(urls);



}