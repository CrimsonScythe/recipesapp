import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/src/blocs/dailyRecipes/dailyRecipes_state.dart';
import 'package:recipes/src/blocs/detailRecipes/detailrecipe_bloc.dart';
import 'package:recipes/src/blocs/detailRecipes/detailrecipe_state.dart';
import 'package:recipes/src/blocs/favourites/favourites_bloc.dart';
import 'package:recipes/src/blocs/favourites/favourites_state.dart';
import 'package:recipes/src/blocs/shopping/shopping_bloc.dart';
import 'package:recipes/src/blocs/textform/textform_bloc.dart';
import 'package:recipes/src/models/recipe.dart';
import 'package:recipes/src/screens/dailyrecipe_screen.dart';
import 'package:recipes/src/screens/detailrecipe_screen.dart';

class DailyRecipesWidget extends StatelessWidget {

  final List<Recipe> recipes;
  final List<String> favourites;
  double height;
  @override
  Widget build(BuildContext context) {
    height = Scaffold.of(context).appBarMaxHeight;
    print(height);
    final title = recipes[0].title;

    final List<Widget> imageSliders = recipes.map((e) =>

        Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            elevation: 5,
            margin: EdgeInsets.all(10),
            child:
            new InkWell(
              splashColor: Colors.white,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                    MultiBlocProvider(
                      providers: [
                        BlocProvider<DetailRecipeBloc>(
                          create: (_) => DetailRecipeBloc(int.parse(e.serve)),
                        ),
                        BlocProvider<ShoppingBloc>(
                          create: (_) => ShoppingBloc(),
                        ),
                        BlocProvider<FavouritesBloc>(
                          create: (_) => FavouritesBloc(),
                        )
                      ],
                      child: RecipeDetailScreen(e,null, int.parse(e.serve)),
                    )
//                    BlocProvider(
//                        create: (_) => DetailRecipeBloc(int.parse(e.serve)),
//                        child: RecipeDetailScreen(recipe: e,)
//                    ),

                    )
                );
                },
              child: Stack(
                children: <Widget>[
                  Hero(tag: e.id, child: Image.file(new File(e.img), fit: BoxFit.cover,height: 600, width: 400,),),
//                  Image.file(new File(e.img), fit: BoxFit.cover,height: 600, width: 400,),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    alignment: Alignment.topLeft,
                    child:
                    Text(e.title, style: TextStyle(backgroundColor: Colors.grey.withOpacity(0.5),fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(color: Colors.grey.withOpacity(0.6), child:
                            Row(children: <Widget>[Icon(Icons.people,color: Colors.white,),Text(e.serve, style: TextStyle(color: Colors.white),) ],),),
                            Container(color: Colors.grey.withOpacity(0.6), child:
                            Row(children: <Widget>[Icon(Icons.access_time,color: Colors.white,),Text('10 mins', style: TextStyle(color: Colors.white),) ],),),
                          ],
                        ),
                      )

                    ],
                  )
                ],
              ),
            )
          )

    ).toList();

    return Container(
      child:
      Column(
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(height: MediaQuery.of(context).size.height-height*2, autoPlay: false,enlargeCenterPage: true),
            items: imageSliders,
          )
//          Text(title),
//          RaisedButton(onPressed: () {
//            Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) =>/// provider here for dailyrecipescreen
////                  DailyRecipeScreen(recipes[0])
//                BlocProvider(
//                  /// initial state?
//                  //todo: change initial state depending on fav
//                  /// if favourite has been added then state is favouritesadded otherwise initial
//                  /// how to handle that checking? local storage? yes
//                  create: (_) => FavouritesBloc(),
//                  child: DailyRecipeScreen(recipes[0])
//                ),
//                )
//            );
//          })
        ],
      ),
    );

  }

  DailyRecipesWidget(this.recipes, this.favourites);
}
