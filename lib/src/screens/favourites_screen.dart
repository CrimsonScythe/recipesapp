import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/src/blocs/favourites/favourites_bloc.dart';
import 'package:recipes/src/blocs/favourites/favourites_event.dart';
import 'package:recipes/src/blocs/favourites/favourites_state.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favourites'),),
      body: BlocBuilder<FavouritesBloc, FavouritesState> (
        builder: (context, state){
          if (state is FavouritesInitial) {
            BlocProvider.of<FavouritesBloc>(context).add(GetFavourites());
            return Center(child: CircularProgressIndicator(),);
          }
          if (state is FavouritesRetrieved) {
//            state.recipes
            return Column(
              children: <Widget>[
                Text(state.favList[0].title),
                Center(child: Text('SUCCESS'),),
                FlatButton(onPressed: () => null , child: null)
              ],
            );
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
