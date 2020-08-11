import 'package:bloc/bloc.dart';
import 'package:recipes/resources/repository.dart';
import 'package:recipes/src/models/recipe.dart';
import 'dailyRecipes_state.dart';

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
          final listRecipes = await loadRecipes();
          print('almost');
          yield RecipesLoadSuccess(listRecipes);
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
    print(recipesList);
    return recipesList;
  }


}