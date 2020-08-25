import 'package:bloc/bloc.dart';
import 'package:recipes/resources/repository.dart';
import 'package:recipes/src/blocs/dailyRecipes/dailyRecipes_state.dart';
import 'package:recipes/src/models/recipe.dart';

enum dRecipesEvent {  dRecipesRequested }

class DailyRecipesBloc extends Bloc<dRecipesEvent, DailyRecipesState> {
  DailyRecipesBloc() : super(RecipesInitial());

  final _repository = Repository();

  @override
  Stream<DailyRecipesState> mapEventToState(event) async* {
    switch (event) {

      case dRecipesEvent.dRecipesRequested:
        /// here we must check the cache also
      /// if cache exists then we return from cache
      /// otherwise fetch
        yield RecipesLoadInProgress();
        try {
          /// get recipes
          final listRecipes = await loadRecipes();
          /// load ingredientslist for shoppingcart
          try{
            await _repository.loadIngredients();
          } catch(e){
            print(e);
          }

          /// get favourites
          // todo: favourites are not actually used, so no need to return?
          final favourites = await _repository.getFavouritesSharedPref();
          yield RecipesLoadSuccess(favourites, listRecipes);
        } catch (_) {
          yield RecipesLoadFailure();
        }

        break;
    }


  }

  Future<List<Recipe>> loadRecipes() async {
    final docs = await _repository.getDailyRecipes();
    final path = await _repository.setDailyRecipes(docs.documents);
    print('path from bloc');
    print(path);
    /// list<recipe>
    final recipesList = await _repository.readDailyRecipes(path);
    print('fromperv');
    print(recipesList[0].id);
    print(recipesList);
    return recipesList;
  }


}