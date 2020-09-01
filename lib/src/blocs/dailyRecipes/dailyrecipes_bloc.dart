import 'package:bloc/bloc.dart';
import 'package:recipes/resources/repository.dart';
import 'package:recipes/src/blocs/dailyRecipes/dailyRecipes_state.dart';
import 'package:recipes/src/models/recipe.dart';
import 'package:recipes/src/models/recipeingredients.dart';
import 'package:recipes/src/services/SpoonApiService.dart';
import 'package:tuple/tuple.dart';

enum dRecipesEvent {  dRecipesRequested }

class DailyRecipesBloc extends Bloc<dRecipesEvent, DailyRecipesState> {
  DailyRecipesBloc() : super(RecipesInitial());

  final _repository = Repository();
  final _spoonapi = SpoonApiService();

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
//          final favourites = await _repository.getFavouritesSharedPref();
          final favourites = await _repository.getStringFavourites();
          _repository.favouritesList=favourites;

          /// here we must get the images for the ingredients

          print('prebv');
//          await getIngredientImages(listRecipes);
          print('WORKSSLJSKGNDGJK');
          yield RecipesLoadSuccess(favourites, listRecipes);
        } catch (_) {
          yield RecipesLoadFailure();
        }

        break;
    }


  }

  Future<void> getIngredientImages(List<Recipe> recipes) async {


    for (int i=0; i<3; i++){
      String nullimg='';
      String imgpath='';
      List<RecipeIngredients> recipeIngredients = new List<RecipeIngredients>();
      for (int j=0; j < recipes[i].ingredients.length; j++)  {

//        final lst = recipes[i].ingredientsnames[j]['name'].toString().split(' ');
//        lst.forEach((element) async {
//          final Tuple2 val = await _spoonapi.getIngredientImg(element);
//          if (!val.item2){
//            print(val.item1);
//            nullimg=val.item1;
//          } else {
//            print(val.item1);
//            imgpath=val.item1;
//          }
//
//        });
//        if (imgpath==''){imgpath=nullimg;}
//        print(recipes[i].ingredientsnames[j]['name']);
        final lstt = recipes[i].ingredientsnames[j]['name'].toString().split(' ');
//        print(lstt[lstt.length-1]);
        imgpath = await _spoonapi.getIngredientImg(lstt[lstt.length-1]);
//        final imgpath = await _spoonapi.getIngredientImg(recipes[i].ingredientsnames[j]['name']);
        recipeIngredients.add(RecipeIngredients(recipes[i].ingredients[j], imgpath));

      }

//      recipes[i].ingredients.forEach((element) async {
//
//
//      });

      recipes[i].ingredients=recipeIngredients;

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