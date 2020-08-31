import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quantity/number.dart';
import 'package:recipes/src/blocs/detailRecipes/detailrecipe_bloc.dart';
import 'package:recipes/src/models/recipe.dart';
import 'package:recipes/src/widgets/minus_widget.dart';
import 'package:recipes/src/widgets/plus_widget.dart';
import 'package:recipes/src/widgets/serve_widget.dart';

class MethodScreen extends StatelessWidget {

  final Recipe recipe;
  final int _defaultServings;
  const MethodScreen(this.recipe, this._defaultServings);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('title'),),
      body: Container(
        child: Column(
          children: [
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
            IngredientsList(context),
            MethodList()
          ],
        )
      ),
    );
  }

  Widget IngredientsList(context) {

    List<Widget> ingredients = recipe.ingredients
        .map((e) =>
        BlocBuilder<DetailRecipeBloc, int>(
            builder: (context, serveState){
              String prefix=e.toString();
              String suffix='';
              Fraction fraction;

              final regcomplex = new RegExp(r'[0-9]\s?(-|–)\s?[0-9]');
              final regsimple = new RegExp(r'[0-9]');
//               final regexMatch = regsimple.firstMatch(e.toString()[0]);
              final regexMatch = regcomplex.firstMatch(e.toString());
              if (regexMatch==null){
                final regm = regsimple.firstMatch(e.toString()[0]);
                if (regm!=null){
                  print(e.toString());
                  prefix = (int.parse(e.toString()[0])/_defaultServings * serveState).toStringAsFixed(2);
                  if (RegExp(r'.00').hasMatch(prefix)){prefix = prefix.split('.')[0];}
                  suffix = e.toString().substring(1);
//                  print(prefix);
                }
              } else {
//                 print(e.toString());
                final suffi = e.toString().split(regcomplex.stringMatch(e.toString()));
                var prefix1 = (int.parse(regcomplex.stringMatch(e.toString())[0])/_defaultServings*serveState).toStringAsFixed(2);
                var prefix2 = (int.parse(regcomplex.stringMatch(e.toString())[2])/_defaultServings*serveState).toStringAsFixed(2);
                if (RegExp(r'.00').hasMatch(prefix1)){prefix1 = prefix1.split('.')[0];}
                if (RegExp(r'.00').hasMatch(prefix2)){prefix2 = prefix2.split('.')[0];}
                String prefixreal = prefix1.toString()+'-'+prefix2.toString();
                prefix=prefixreal;
                suffix=suffi[1];

              }

              final fracReg = new RegExp(r'[0-9]\s?/\s?[0-9]');
              final fracreg2=new RegExp(r'½');
              if (fracReg.hasMatch(e.toString())){
                fraction=Fraction(int.parse(fracReg.stringMatch(e.toString())[0]), int.parse(fracReg.stringMatch(e.toString())[2]));
                final suffi = e.toString().split(fracReg.stringMatch(e.toString()));
                suffix=suffi[1];
                var prefix1 = (fraction/_defaultServings*serveState).toDouble().toStringAsFixed(2);
                prefix=prefix1;
              }
              if (fracreg2.hasMatch(e.toString())){
                fraction=Fraction(1,2);
                final suffi = e.toString().split(fracreg2.stringMatch(e.toString()));
                suffix=suffi[1];
                var prefix1 = (fraction/_defaultServings*serveState).toDouble().toStringAsFixed(2);
                prefix=prefix1;
              }

              return Center(child: Text(prefix+ ' '+suffix, style: TextStyle(),),);

            })).toList();

    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: ingredients,
      ),
    );

  }

  Widget MethodList() {

    List<Widget> methods = recipe.instructions
        .map((e) =>

              Center(child: Text(e.toString(), style: TextStyle(),),)

            ).toList();

    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: methods,
      ),
    );

  }

  void func() {

  }
}
