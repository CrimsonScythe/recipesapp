import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;

  RecipeDetailScreen({Key key, this.recipe}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RecipeDetailScreenState();
}

class RecipeDetailScreenState extends State<RecipeDetailScreen> {

  ScrollController _scrollController = new ScrollController();
  bool _show = false;

  void handleScroll() async {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideFloationButton();
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        showFloationButton();
      }
    });
  }

  @override
  void initState() {
    super.initState();
//    handleScroll();
  }


  @override
  void dispose() {
    _scrollController.removeListener(() {
    });
    super.dispose();
  }

  void showFloationButton() {
    setState(() {
      _show = true;
    });
  }

  void hideFloationButton() {
    setState(() {
      _show = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget IngredientsGrid(context) {
      List<Widget> ingredients = widget.recipe.ingredients
          .map((e) => BlocBuilder<ShoppingBloc, ShoppingState>(
                  builder: (context, state) {
//          state is IngredientsState? print(state.keys):print('no');
                return GridTile(
                  child: Container(
                    child: InkWell(
                      child: state is IngredientsState &&
                              state.keys.contains(e.toString())
                          ? Image.asset('assets/ing_images/004-fish.png')
                          : Image.asset('assets/ing_images/001-jam.png'),
                      onTap: () {
                        BlocProvider.of<ShoppingBloc>(context).add(
                            state is IngredientsState &&
                                    state.keys.contains(e.toString())
                                ? DeselectIngredient(e.toString())
                                : SelectIngredient(e.toString()));
                      },
                    ),
                    margin: EdgeInsets.all(25),
                  ),
                  footer: Text(e.toString(), textAlign: TextAlign.center),
                );
              }))
          .toList();

      return Expanded(child:
          BlocBuilder<ShoppingBloc, ShoppingState>(builder: (context, state) {
        print('state');
        state is IngredientsState ? print(state.keys) : print('no work');
        return GridView.count(
            padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 48),
//            controller: _scrollController,
            // todo: how to determine corss azid count?
            crossAxisCount: 3,
            children: ingredients);
      }));
    }

    Widget localWidget(context) {
      return Container(
        child: Column(
          children: <Widget>[
            Text('Servings'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                minusButton(context),
                SizedBox(
                  width: 15,
                ),
                serveWidget(),
                SizedBox(
                  width: 15,
                ),
                plusButton(context)
              ],
            ),
            Text('Ingredients'),
            IngredientsGrid(context),
//            SizedBox(height: 10.0,)
          ],
        ),
      );
    }

    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
          headerSliverBuilder: (context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 300.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(widget.recipe.title),
                    background: Hero(
                      tag: widget.recipe.id,
                      child: Image.file(
                        new File(widget.recipe.img),
                        fit: BoxFit.cover,
                      ),
                    )),
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
          body: localWidget(context)),
      floatingActionButton:
          BlocBuilder<ShoppingBloc, ShoppingState>(
              builder: (context, state) {
//                return FloatingActionButton.extended(onPressed: (){},icon: Icon(Icons.add), label: Text('Add to shopping cart'));
                return AnimatedOpacity(
                  opacity: 1.0,
                  duration: Duration(milliseconds: 500),
                  child: FloatingActionButton.extended(
                      onPressed: () {
                        (state as IngredientsState).keys.length==0?
                        print('Next')
                        :
                        BlocProvider.of<ShoppingBloc>(context).add(AddIngredientsToList((state as IngredientsState).keys))
                        ;
                      },
                      icon: Icon((state as IngredientsState).keys.length==0? Icons.navigate_next:Icons.add),
                      backgroundColor: (state as IngredientsState).keys.length==0? Colors.red:Colors.blue,
                      label: Text((state as IngredientsState).keys.length==0?'Show method':'Add to shopping cart')
                  ),
                );

              }

          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,


//          Visibility(
//            visible: _show,
//              child:  FloatingActionButton.extended(
//                onPressed: () {},
//                icon: Icon(Icons.add),
//                label: Text('Add to shopping cart'),
//              ),
//          )
    );
  }
}
