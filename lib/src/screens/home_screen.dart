import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/src/blocs/dailyRecipes/dailyRecipes_state.dart';
import 'package:recipes/src/blocs/dailyRecipes/dailyrecipes_bloc.dart';
import 'package:recipes/src/widgets/dailyrecipes_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext homecontext) {
    return Scaffold(
      appBar: AppBar(title: Text('Home'),),
      body: BlocBuilder<DailyRecipesBloc, DailyRecipesState>(
        builder: (context, state){
          if (state is RecipesInitial){
            /// check sharedpref for favourites
//            repo.favouritesList = repo.getFavourites(repo.user.uID);
            /// load recipes from db
            BlocProvider.of<DailyRecipesBloc>(context).add(dRecipesEvent.dRecipesRequested);
            return Center(child: CircularProgressIndicator(),);
          }
          if (state is RecipesLoadSuccess) {

            /// favourites have also bveen loaded so we add evetn to bloc
//            BlocProvider.of<FavouritesBloc>(context).add(favouritesLoaded);

            /// pass recipes list to daily home widget
            ///
//            print('recipe id is');
//            print(state.recipes[0].id);
//            print('fav');
//            for (final e in state.favourites) {print(e);}

//
//            return DailyRecipesWidget(state.recipes, state.favourites,
//                state.favourites.contains(state.recipes[0].id)?
//            FavouriteAdded() : FavouritesInitial());

          return DailyRecipesWidget(state.recipes, state.favourites);

          }
          if (state is RecipesLoadFailure) {
            return Center(child: Text('Error'),);
          }
          return Center(child: CircularProgressIndicator(),);
        },
      ),

    );
  }
}
