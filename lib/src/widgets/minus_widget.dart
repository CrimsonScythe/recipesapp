import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/src/blocs/detailRecipes/detailrecipe_bloc.dart';
import 'package:recipes/src/blocs/detailRecipes/detailrecipe_event.dart';

Widget minusButton(context) {
  return ClipOval(
    child: Material(
      color: Colors.blue, // button color
      child: InkWell(
        splashColor: Colors.grey, // inkwell color
        child: SizedBox(width: 56, height: 56, child: Icon(Icons.remove)),
        onTap: () {
          BlocProvider.of<DetailRecipeBloc>(context).add(Decrement());
        },
      ),
    ),
  );
}