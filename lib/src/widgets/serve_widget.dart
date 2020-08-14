import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/src/blocs/detailRecipes/detailrecipe_bloc.dart';
import 'package:recipes/src/blocs/detailRecipes/detailrecipe_state.dart';

Widget serveWidget() {
  return BlocBuilder<DetailRecipeBloc, int>(
      builder: (context, state) {
        return Text(state.toString());
      }
  );
}