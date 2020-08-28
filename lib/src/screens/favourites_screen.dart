import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/src/blocs/detailRecipes/detailrecipe_bloc.dart';
import 'package:recipes/src/blocs/favourites/favourites_bloc.dart';
import 'package:recipes/src/blocs/favourites/favourites_event.dart';
import 'package:recipes/src/blocs/favourites/favourites_state.dart';
import 'package:recipes/src/blocs/shopping/shopping_bloc.dart';

import 'detailrecipe_screen.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favourites'),),
      body: BlocBuilder<FavouritesBloc, FavouritesState> (
        builder: (bloccontext, state){
          if (state is FavouritesInitial) {
            BlocProvider.of<FavouritesBloc>(bloccontext).add(GetFavourites());
            return Center(child: CircularProgressIndicator(),);
          }
          if (state is FavouritesRetrieved) {

//            print('id0');
//            print(state.favList[0].id);
//            print('id1');
//            print(state.favList[1].id);


                return ListView(

                    children: state.favList.map((e) =>

                        Container(
                          height: 200,
                          margin: EdgeInsets.all(15),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            elevation: 5,
//                            margin: EdgeInsets.all(10),
                            child: InkWell(
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
                                            BlocProvider<FavouritesBloc>(
                                              create: (_) => FavouritesBloc(),
                                            )
                                          ],
                                          child: RecipeDetailScreen(e, BlocProvider.of<FavouritesBloc>(bloccontext)),
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
                                  Hero(tag: e.id, child: Image.network(e.img, fit: BoxFit.cover,height: 600, width: 400,),),
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
                            ),
                          ),
                        )
                    ).toList()
                );

//            );
          }
          if (state is NoFavourites) {
            return Center(child: Text('No Favourites'));
          }
          if (state is FavouritesFailure) {
            return Center(child: Text('Error'),);
          }
          return Container();
        },
      )
    );
  }
}
