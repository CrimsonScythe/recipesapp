import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/src/blocs/favourites/favourites_bloc.dart';
import 'package:recipes/src/blocs/favourites/favourites_state.dart';
import 'package:recipes/src/models/recipe.dart';
import 'package:recipes/src/screens/dailyrecipe_screen.dart';

class DailyRecipesWidget extends StatelessWidget {

  final List<Recipe> recipes;

  @override
  Widget build(BuildContext context) {
    final title = recipes[0].title;
    return Container(
      child: Column(
        children: <Widget>[
          Text(title),
          RaisedButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>/// provider here for dailyrecipescreen
                BlocProvider(
                  /// initial state?
                  //todo: change
                  /// if favourite has been added then state is favouritesadded otherwise initial
                  /// how to handle that checking? local storage? yes
                  create: (_) => FavouritesBloc(FavouritesInitial()),
                  child: DailyRecipeScreen(recipes[0])),
                )

            );
          })
        ],
      ),
    );
  }

  DailyRecipesWidget(this.recipes);
}
