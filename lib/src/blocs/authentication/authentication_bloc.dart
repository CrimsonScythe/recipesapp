import 'package:bloc/bloc.dart';
import 'package:recipes/resources/repository.dart';
import 'package:recipes/src/blocs/authentication/authentication_event.dart';
import 'package:recipes/src/blocs/authentication/authentication_state.dart';
import 'package:recipes/src/models/recipe.dart';




class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(Unknown());

  final _repository = Repository();

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