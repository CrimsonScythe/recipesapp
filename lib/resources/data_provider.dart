import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' show get;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipes/src/models/recipe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../src/constants.dart' as Constants;
import 'package:intl/intl.dart';


class DataProvider {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.json');
  }

  Future<void> writeRecipe(String jsonString, i) async {
    final path = await _localPath;

    final file = File('$path/$i.json');

    // Write the file.
    file.writeAsStringSync(jsonString);

  }

  Future<List<Recipe>> readDailyRecipes(path) async {

    List<Recipe> recipesList= new List(3);
    for (int i=0; i<3; i++){
      print('parsing');
      final file = File('$path/$i.json');
      String jsonString = await file.readAsString();
      Map recipeMap = jsonDecode(jsonString);
      print('decoded');
      var recipe = Recipe.fromJson(recipeMap);
      print('recJ');
      recipesList[i] = recipe;
      print('added');
    }

    return recipesList;
  }



  /// save to shared pref
  /// overwritten automat.
  Future<void> setFavourite(recipeID) async {

    List<String> strList;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('FAV')) {
      strList = prefs.getStringList('FAV');
      for (final k in strList) {
        print(k);
      }
      if (strList.length==3){
        await prefs.clear();
        strList.add(recipeID);
        await prefs.setStringList('FAV', strList);
      } else {
        strList.add(recipeID);
        await prefs.setStringList('FAV', strList);
      }
    } else {
      List<String> strList = new List<String>();
      strList.add(recipeID);
      await prefs.setStringList('FAV', strList);
    }


  }

  Future<bool> deleteFavourite(recipeID) async {
    List<String> strList;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('FAV')){
      strList = prefs.getStringList('FAV');
      strList.removeWhere((element) => element==recipeID);
      return await prefs.setStringList('FAV', strList);
    } else {
      return false;
    }
  }

  Future<List<String>> getFavouritesSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('FAV')){
      return prefs.getStringList('FAV');
    } else {
      return new List<String>();
    }
  }

  Future<bool> existFavourite(recipeID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('FAV')){
      final strList = prefs.getStringList('FAV');
      return strList.contains(recipeID);
    } else {
      return false;
    }
  }

  /// save to localstorage
  Future<String> setDailyRecipes(List<DocumentSnapshot> recipeSnapshots) async {
//    final documentSnapshot = List<DocumentSnapshot>();

    /// write data to file
    int i = 0;
    for (final recipe in recipeSnapshots){


      String imgUrl = recipe.data['img'];

      if (!imgUrl.contains(new RegExp(r'(http)|(https)', caseSensitive: false))){
        imgUrl='http://'+imgUrl;
      }

      print(imgUrl);


      var response = await get(imgUrl);


      final docDirect = await getApplicationDocumentsDirectory();
      File file = new File(join(docDirect.path, '$i.jpg'));
      final filesaved = await file.writeAsBytes(response.bodyBytes);

      print('filepath');
      print(filesaved.path);


//      recipe.data['img'] = filesaved.path;
//      print('path confirm');
//      print(recipe.data['img']);
//      print(recipe.data['ingredients'].first);


      /// create Recipe object from firebase data
      final recipetoJ = Recipe.fromJson(recipe.data);
      /// change image path to reflect local path storage
      recipetoJ.img=filesaved.path;

//      print('id');
//      print(recipe.documentID);
//      print('reference');
      print(recipe.reference.path);
//      print(recipe.reference.path.split('/')[1]);
      /// add id from docID because didnt do it in python
      recipetoJ.id=recipe.reference.path;
      print(recipetoJ.id);
      print('printed');
      /// encode json
      String json = jsonEncode(recipetoJ);
      print('encoded');
      /// write encoded json to file
      await writeRecipe(json, i);
      print('written');

      i = i+1;
    }
    print('works');
    return _localPath;
    /// write data to cache?


  }


}