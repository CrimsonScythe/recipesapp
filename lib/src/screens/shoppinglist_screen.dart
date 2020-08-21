import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/src/blocs/shoppinglist/shoppinglist_bloc.dart';
import 'package:recipes/src/blocs/shoppinglist/shoppinglist_event.dart';
import 'package:recipes/src/blocs/shoppinglist/shoppinglist_state.dart';
import 'package:recipes/src/models/rootlist.dart';

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
                  )

//                  Row(/// show recipe cards
//                    children:
//
//                  ),
                  /// show ingredients lists
//                  Column(
//                    children:
//                    _rootlist.shplist.map((e) => null).toList(),
//                  )
                ],
              );
            }
            return Center(child: CircularProgressIndicator(),);
          }
      ),
    );
  }
}
