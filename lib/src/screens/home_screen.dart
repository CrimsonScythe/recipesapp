import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/src/blocs/dailyRecipes/dailyRecipes_state.dart';
import 'package:recipes/src/blocs/dailyRecipes/dailyrecipes_bloc.dart';
import 'package:recipes/src/widgets/dailyrecipes_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext homecontext) {
    return Scaffold(
      appBar: AppBar(title: Text('Home'),),
      body: BlocBuilder<DailyRecipesBloc, DailyRecipesState>(
        builder: (context, state){
          if (state is RecipesInitial){
            BlocProvider.of<DailyRecipesBloc>(context).add(dRecipesEvent.dRecipesRequested);
            return Center(child: CircularProgressIndicator(),);
          }
          if (state is RecipesLoadSuccess) {
            /// pass recipes list to daily home widget
            return DailyRecipesWidget(state.recipes);
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
