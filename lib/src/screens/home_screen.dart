import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/src/blocs/dailyRecipes/dailyRecipes_state.dart';
import 'package:recipes/src/blocs/dailyrecipes_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home'),),
      body: BlocBuilder<DailyRecipesBloc, DailyRecipesState>(
        builder: (context, state){
          if (state is RecipesInitial){
            BlocProvider.of<DailyRecipesBloc>(context).add(dRecipesEvent.dRecipesRequested);
            return Center(child: CircularProgressIndicator(),);
          }
          if (state is RecipesLoadSuccess) {
//            state.recipes
            return Center(child: Text('SUCCESS'),);
          }
          if (state is RecipesLoadFailure) {
            return Center(child: Text('Error'),);
          }
          return Container();
        },
      ),

    );
  }
}
