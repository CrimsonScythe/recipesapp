import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/src/blocs/favourites/favourites_bloc.dart';
import 'package:recipes/src/blocs/favourites/favourites_event.dart';
import 'package:recipes/src/blocs/favourites/favourites_state.dart';
import 'package:recipes/src/models/recipe.dart';

class DailyRecipeScreen extends StatelessWidget {

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: BlocBuilder<FavouritesBloc, FavouritesState>(
          builder: (context, state) {
            return AppBar(
              actions: <Widget>[
                IconButton(
                  icon: state is FavouriteAdded?
                  Icon(Icons.favorite):Icon(Icons.favorite_border),
                  onPressed: () {
                    BlocProvider.of<FavouritesBloc>(context).add(
                        state is FavouriteAdded?
                        RemoveFavourite(recipe.id) : AddFavourite(recipe.id)///passing id here...
                    );
                    /// TOAST ADDING RECIPE
                  },
                )
              ],
            );
          },
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(recipe.title),
          ],
        ),
      ),
    );
  }

  DailyRecipeScreen(this.recipe);


}
