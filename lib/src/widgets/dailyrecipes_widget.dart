import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/src/blocs/dailyRecipes/dailyRecipes_state.dart';
import 'package:recipes/src/blocs/favourites/favourites_bloc.dart';
import 'package:recipes/src/blocs/favourites/favourites_state.dart';
import 'package:recipes/src/models/recipe.dart';
import 'package:recipes/src/screens/dailyrecipe_screen.dart';

class DailyRecipesWidget extends StatelessWidget {

  final List<Recipe> recipes;
  final List<String> favourites;

  @override
  Widget build(BuildContext context) {

    final title = recipes[0].title;


    return Container(
      child:
      Column(
        children: <Widget>[
          Text(title),
          RaisedButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>/// provider here for dailyrecipescreen
//                  DailyRecipeScreen(recipes[0])
                BlocProvider(
                  /// initial state?
                  //todo: change initial state depending on fav
                  /// if favourite has been added then state is favouritesadded otherwise initial
                  /// how to handle that checking? local storage? yes
                  create: (_) => FavouritesBloc(),
                  child: DailyRecipeScreen(recipes[0])
                ),

                )

            );
          })
        ],
      ),
    );
  }

  DailyRecipesWidget(this.recipes, this.favourites);
}
