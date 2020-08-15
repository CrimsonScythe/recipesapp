import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/src/blocs/detailRecipes/detailrecipe_bloc.dart';
import 'package:recipes/src/blocs/detailRecipes/detailrecipe_state.dart';
import 'package:recipes/src/blocs/shopping/shopping_bloc.dart';
import 'package:recipes/src/blocs/shopping/shopping_event.dart';
import 'package:recipes/src/blocs/shopping/shopping_state.dart';
import 'package:recipes/src/models/recipe.dart';
import 'package:recipes/src/widgets/minus_widget.dart';
import 'package:recipes/src/widgets/plus_widget.dart';
import 'package:recipes/src/widgets/serve_widget.dart';

class RecipeDetailScreen extends StatelessWidget {

  final Recipe recipe;


  RecipeDetailScreen({Key key, this.recipe}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, bool innerBoxIsScrolled) {
          return <Widget> [
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title:
                Text(recipe.title),
                background: Hero(tag: recipe.id, child: Image.file(new File(recipe.img), fit: BoxFit.cover,),)
              ),
            )
//            SliverAppBar(
//              expandedHeight: 200.0,
//              floating: false,
//              pinned: true,
//              backgroundColor: Colors.transparent,
//              flexibleSpace: FlexibleSpaceBar(
//                  centerTitle: true,
//                  title:
//                  Text(recipe.title),
//                  background: Container(color: Colors.grey,),
//              ),
//            )
          ];
        },
        body: localWidget(context)
      ),
      floatingActionButton: FloatingActionButton.extended(

        onPressed: () {},
        icon: Icon(Icons.add),
        label: Text('Add to shopping cart'),
      ),
    );
  }


  Widget localWidget(context) {
    return Container(
      child:
      Column(
        children: <Widget>[
          Text('Servings'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              minusButton(context),
              SizedBox(width: 15,),
              serveWidget(),
              SizedBox(width: 15,),
              plusButton(context)
            ],
          ),
          Text('Ingredients'),
          IngredientsGrid(context),
        ],
      ),
    );
  }


  Widget IngredientsGrid(context) {



    List<Widget> ingredients = recipe.ingredients.map((e) =>
    BlocBuilder<ShoppingBloc, ShoppingState>(
        builder: (context, state){
//          state is IngredientsState? print(state.keys):print('no');
          return GridTile(
            child: Container(child: InkWell(
              child:state is IngredientsState && state.keys.contains(e.toString()) ? Image.asset('assets/ing_images/004-fish.png'):Image.asset('assets/ing_images/001-jam.png'),
              onTap: (){
                BlocProvider.of<ShoppingBloc>(context).add(state is IngredientsState && state.keys.contains(e.toString())? DeselectIngredient(e.toString()) : SelectIngredient(e.toString()));
              },),
              margin: EdgeInsets.all(25),),
            footer: Text(e.toString(), textAlign: TextAlign.center),
          );
        }
    )
    ).toList();

    return Expanded(
        child:
            BlocBuilder<ShoppingBloc, ShoppingState>(
                builder: (context, state) {
                  print('state');
                  state is IngredientsState? print(state.keys):print('no work');
                  return GridView.count(
                    // todo: how to determine corss azid count?
                      crossAxisCount: 3,
                      children: ingredients
                  );
                }
            )
    );

  }

}
