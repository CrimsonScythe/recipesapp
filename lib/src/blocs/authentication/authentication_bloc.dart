import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:recipes/resources/repository.dart';
import 'package:recipes/src/blocs/authentication/authentication_event.dart';
import 'package:recipes/src/blocs/authentication/authentication_state.dart';
import 'package:recipes/src/models/favourite.dart';
import 'package:recipes/src/models/recipe.dart';




class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(Unknown());

  final _repository = Repository();

  Future<void> syncData() async {

    /// get from local db
    List<Favourite> favListHive = await _repository.getFavouritesLocalHive();
    /// get from firestore db
    List<Favourite> favListFire = await _repository.getFavouritesFirebase(_repository.user.uID);


    /// use shared prefs to check if first launch
    /// then set favs to hive
//    if (favListHive.length==0 && favListFire.length>0){
//      await _repository.setFavouritesToHive(favListFire);
//      return;
//    }

    /// if both empty then do nothing
    if (favListHive.length==0 && favListFire.length==0){
      return;
    }

    /// upload new data to firestore
    if (!listEquals(favListFire, favListHive)){
      await _repository.setFavouritesToFirebase(favListHive, _repository.user.uID);
      return;
    }

    return;

  }

  @override
  Stream<AuthenticationState> mapEventToState(event) async* {
    if (event is LogOutRequested) {
      _repository.logOut();

    }
    if (event is LogInRequestedAnon) {
      /// get user params
      final user = await _repository.logInAnon();
      /// save user obj to repo
      _repository.user = user;
      /// update db with userparams
      await _repository.addUser(user);

      /// if (fstore is empty or app data is more recent(diff)) then upload to fstore from app
      /// if (app is empty and fstore is not) then download from fstore to app
      /// if both empty then do nothing

      await syncData();

      /// return success
      yield Authenticated();



    }


  }

//  Future<List<Recipe>> loadRecipes() async {
//    final docs = await _repository.getDailyRecipes();
//    final path = await _repository.setDailyRecipes(docs.documents);
//    print('path from bloc');
//    print(path);
//    /// list<recipe>
//    final recipesList = await _repository.readDailyRecipes(path);
//    print(recipesList);
//    return recipesList;
//  }
//
//  Stream<DailyRecipesState> _setRecipes() async* {
//
//    //todo: try - catch here ????
//    final recipeDocs = await _repository.getDailyRecipes();
//    await _repository.setDailyRecipes(recipeDocs.documents);
//
//  }

}