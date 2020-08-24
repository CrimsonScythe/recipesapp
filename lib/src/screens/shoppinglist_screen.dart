import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/src/blocs/detailRecipes/detailrecipe_bloc.dart';
import 'package:recipes/src/blocs/shopping/shopping_bloc.dart';
import 'package:recipes/src/blocs/shoppinglist/shoppinglist_bloc.dart';
import 'package:recipes/src/blocs/shoppinglist/shoppinglist_event.dart';
import 'package:recipes/src/blocs/shoppinglist/shoppinglist_state.dart';
import 'package:recipes/src/models/rootlist.dart';
import 'package:recipes/src/screens/detailrecipe_screen.dart';

class ShoppingListScreen extends StatelessWidget {

  final RootList _rootlist;

  ShoppingListScreen(this._rootlist);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_rootlist.name),),
      body: BlocBuilder<ShoppingListBloc, ShoppingListState>(
          builder: (context, state) {

            if (state is ShoppingListStateInitial) {
              BlocProvider.of<ShoppingListBloc>(context).add(ParseShoppingLists(_rootlist.shplist));
              return Center(child: CircularProgressIndicator(),);
            }
            if (state is RecipesListLoaded) {

              return Column(
                children: <Widget>[
                  Container(
                    height: 200,
                    child:
                    ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: state.recipesList.map((e) =>
                          Container(
                            height: 200,
                            width: 250,
                            child:
                            Card(
                              child:
                              InkWell(
                                onTap: (){
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
//                        BlocProvider<TextFormBloc>(
//                          create: (_) => TextFormBloc(),
//                        )
                                            ],
                                            child: RecipeDetailScreen(recipe: e,),
                                          )
//                    BlocProvider(
//                        create: (_) => DetailRecipeBloc(int.parse(e.serve)),
//                        child: RecipeDetailScreen(recipe: e,)
//                    ),

                                      )
                                  );
                                },
                                child:
                                Stack(
                                  children: <Widget>[
                                    Hero(tag: e.id, child: Image.network(e.img, fit: BoxFit.cover, height: 200, width: 250,)),
                                    Container(
                                      margin: EdgeInsets.all(10.0),
                                      alignment: Alignment.topLeft,
                                      child: Text(e.title, style: TextStyle(backgroundColor: Colors.grey.withOpacity(0.5),fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),),
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
                                )
                                ,
                              ),
                            )
                            ,
                          )
                      ).toList(),

                    ),
                  ),
                  Container(

                    child:
                    ListView(
                      shrinkWrap: true,
                      children: state.ingList.map((e) =>

                          Dismissible(
                              background: Container(color: Colors.red, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[Padding(padding: EdgeInsets.only(left: 10.0), child: Icon(Icons.delete, color: Colors.white,),),Padding(padding: EdgeInsets.only(right: 10.0), child: Icon(Icons.delete, color: Colors.white,),)],),),
                              key: Key(e),
                              onDismissed: (direction) {

                                BlocProvider.of<ShoppingListBloc>(context).add(RemoveIngredient(e, _rootlist.docID));
                                // todo should wait before showing snackbar but ok
                                Scaffold.of(context)
                                    .showSnackBar(SnackBar(content: Text('$e removed')));
                              },
                              child: ListTile(
                                leading: Image.asset('assets/ing_images/004-fish.png'),
                                title: Text(e),
                                onTap: () {},
                              )
                          )

                      )
                          .toList(),
                    ),
                  )
                ],
              );
            }
            return Center(child: CircularProgressIndicator(),);
          }
      ),
    );
  }
}
