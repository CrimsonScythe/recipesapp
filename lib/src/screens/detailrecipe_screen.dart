import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:quantity/quantity.dart';
import 'package:recipes/src/blocs/detailRecipes/detailrecipe_bloc.dart';
import 'package:recipes/src/blocs/dialoglists/dialoglists_bloc.dart';
import 'package:recipes/src/blocs/dialoglists/dialoglists_event.dart';
import 'package:recipes/src/blocs/dialoglists/dialoglists_state.dart';
import 'package:recipes/src/blocs/favourites/favourites_bloc.dart';
import 'package:recipes/src/blocs/favourites/favourites_event.dart';
import 'package:recipes/src/blocs/favourites/favourites_state.dart';
import 'package:recipes/src/blocs/shopping/shopping_bloc.dart';
import 'package:recipes/src/blocs/shopping/shopping_event.dart';
import 'package:recipes/src/blocs/shopping/shopping_state.dart';
import 'package:recipes/src/blocs/textform/textform_bloc.dart';
import 'package:recipes/src/blocs/textform/textform_event.dart';
import 'package:recipes/src/blocs/textform/textform_state.dart';
import 'package:recipes/src/models/favourite.dart';
import 'package:recipes/src/models/recipe.dart';
import 'package:recipes/src/screens/method_screen.dart';
import 'package:recipes/src/services/SpoonApiService.dart';
import 'package:recipes/src/widgets/minus_widget.dart';
import 'package:recipes/src/widgets/plus_widget.dart';
import 'package:recipes/src/widgets/serve_widget.dart';
import 'package:tuple/tuple.dart';


class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;
  final FavouritesBloc _favbloc;
  final int _defaultServings;
  RecipeDetailScreen(this.recipe, this._favbloc, this._defaultServings);

  @override
  Widget build(BuildContext context) {




    if (BlocProvider.of<FavouritesBloc>(context).existFavourite(recipe.id)){
      BlocProvider.of<FavouritesBloc>(context).add(FavouriteSharedAdded());
    } else {
      BlocProvider.of<FavouritesBloc>(context).add(FavouriteSharedNotAdded());
    }


          return Scaffold(
            body:


            NestedScrollView(
                headerSliverBuilder: (context, bool innerBoxIsScrolled) {
                  return <Widget>[
//

                    SliverAppBar(
                      actions: [

                        BlocBuilder<FavouritesBloc, FavouritesState>(builder: (context, state) {


                         return IconButton(icon: Icon(state is FavouriteAdded? Icons.favorite:Icons.favorite_border),
                              onPressed: (){
                                if (state is FavouriteRemoved){
                                  BlocProvider.of<FavouritesBloc>(context).add(AddFavourite(recipe.id));
                                } else {

                                  if (_favbloc!=null){
                                    _favbloc.add(RefreshFavourites());
                                  }


                                BlocProvider.of<FavouritesBloc>(context).add(RemoveFavourite(recipe.id));
                                }
                              });

                        })

                      ],
                      expandedHeight: 300.0,
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: Text(recipe.title),
                          background: Hero(
                            tag: recipe.id,
                            child: recipe.img.contains(new RegExp(r'(http)|(https)',
                                caseSensitive: false))
                                ? Image.network(
                              recipe.img,
                              fit: BoxFit.cover,
                            )
                                : Image.file(
                              new File(recipe.img),
                              fit: BoxFit.cover,
                            ),
                          )),
                    )
                  ];
                },
                body: localWidget(context))
            ,
            floatingActionButton:
            BlocBuilder<ShoppingBloc, ShoppingState>(builder: (contexts, state) {
//                return FloatingActionButton.extended(onPressed: (){},icon: Icon(Icons.add), label: Text('Add to shopping cart'));
              return AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(milliseconds: 500),
                child: FloatingActionButton.extended(
                    onPressed: () {
                      (state as IngredientsState).keys.length == 0
                          ? _showMethod(context, BlocProvider.of<DetailRecipeBloc>(context).state)
                          : _showDialog(
                          (state as IngredientsState).keys, contexts, state);
//                    _showDialog(
//                        (state as IngredientsState).keys, contexts, state);

                      /// show dialog box
                      /// remember to clear list with below to reset state
//                        BlocProvider.of<ShoppingBloc>(context).add(AddIngredientsToList((state as IngredientsState).keys, widget.recipe.id))
                          ;
                    },
                    icon: Icon((state as IngredientsState).keys.length == 0
                        ? Icons.navigate_next
                        : Icons.add),
                    backgroundColor: (state as IngredientsState).keys.length == 0
                        ? Colors.red
                        : Colors.blue,
                    label: Text((state as IngredientsState).keys.length == 0
                        ? 'Show method'
                        : 'Add to shopping cart')),
              );
            }),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          );

  }

  Widget IngredientsGrid(context, state) {

    List<Widget> ingredients = recipe.ingredientsnames
        .map((e) =>
             BlocBuilder<DetailRecipeBloc, int>(builder: (context, serveState) {

//               e.toString().replaceAll(RegExp(r'about\s'), '');
//               print(serveState);
               String prefix=e['measure'].toString();
               String suffix='';
               Fraction fraction;

                             final regcomplex = new RegExp(r'[0-9]\s?(-|–)\s?[0-9]');
               final regsimple = new RegExp(r'[0-9]');
//               final regexMatch = regsimple.firstMatch(e.toString()[0]);
               final regexMatch = regcomplex.firstMatch(e['measure'].toString());
               if (regexMatch==null){
                final regm = regsimple.firstMatch(e['measure'].toString()[0]);
                if (regm!=null){
                  print(e['measure'].toString());
                  prefix = (int.parse(e['measure'].toString()[0])/_defaultServings * serveState).toStringAsFixed(2);
                  if (RegExp(r'.00').hasMatch(prefix)){prefix = prefix.split('.')[0];}
                  suffix = e['measure'].toString().substring(1);
//                  print(prefix);
                }
               } else {
//                 print(e.toString());
                 final suffi = e['measure'].toString().split(regcomplex.stringMatch(e['measure'].toString()));
                 var prefix1 = (int.parse(regcomplex.stringMatch(e.name.toString())[0])/_defaultServings*serveState).toStringAsFixed(2);
                 var prefix2 = (int.parse(regcomplex.stringMatch(e.name.toString())[2])/_defaultServings*serveState).toStringAsFixed(2);
                 if (RegExp(r'.00').hasMatch(prefix1)){prefix1 = prefix1.split('.')[0];}
                 if (RegExp(r'.00').hasMatch(prefix2)){prefix2 = prefix2.split('.')[0];}
                 String prefixreal = prefix1.toString()+'-'+prefix2.toString();
                 prefix=prefixreal;
                 suffix=suffi[1];

               }
               final fracReg = new RegExp(r'[0-9]\s?/\s?[0-9]');
               final fracreg2=new RegExp(r'½');
               if (fracReg.hasMatch(e['measure'].toString())){
                 fraction=Fraction(int.parse(fracReg.stringMatch(e['measure'].toString())[0]), int.parse(fracReg.stringMatch(e['measure'].toString())[2]));
                 final suffi = e['measure'].toString().split(fracReg.stringMatch(e['measure'].toString()));
                 suffix=suffi[1];
                 var prefix1 = (fraction/_defaultServings*serveState).toDouble().toStringAsFixed(2);
                 prefix=prefix1;
               }
               if (fracreg2.hasMatch(e['measure'].toString())){
                 fraction=Fraction(1,2);
                 final suffi = e['measure'].toString().split(fracreg2.stringMatch(e['measure'].toString()));
                 suffix=suffi[1];
                 var prefix1 = (fraction/_defaultServings*serveState).toDouble().toStringAsFixed(2);
                 prefix=prefix1;
               }

//          state is IngredientsState? print(state.keys):print('no');
               return ListTile(
                 title: Text(e['name']),
                  subtitle: Text(e['measure']),
                  leading: state is IngredientsState &&
                         state.keys.contains(Tuple2(e['name'].toString(), e['measure'].toString()))
                         ? Icon(Icons.check,color: Colors.black,):Icon(Icons.check, color: Colors.grey.withAlpha(100),),
//                 child: Container(
//                   child: InkWell(
//                     child: state is IngredientsState &&
//                         state.keys.contains(e.name.toString())
//                         ? Stack(children: [
//                       Image.file(File(e.img)),
//                           Center(child: Container(child: Center(child: Icon(Icons.check),),decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.withAlpha(150)),),),],)
//                         : Image.file(File(e.img)),
                     onTap: () {
                       BlocProvider.of<ShoppingBloc>(context).add(
                           state is IngredientsState &&
                               state.keys.contains(Tuple2(e['name'].toString(), e['measure'].toString()))
                               ? DeselectIngredient(Tuple2(e['name'].toString(), e['measure'].toString()))
                               : SelectIngredient(Tuple2(e['name'].toString(), e['measure'].toString())));
                     },
//                   ),
//                   margin: EdgeInsets.all(25),
//                 ),
//                 footer:
//                 Text((prefix + ' ' + suffix), textAlign: TextAlign.center),

               );
             }))
        .toList();

    return Expanded(child:
//        BlocBuilder<ShoppingBloc, ShoppingState>(builder: (context, state) {
//      print('state');
//      state is IngredientsState ? print(state.keys) : print('no work');
      ListView (
          padding:
              const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 48),
//            controller: _scrollController,
          // todo: how to determine corss azid count?
//          crossAxisCount: 3,
          children: ingredients
      )
//    })
    );
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
          BlocBuilder<ShoppingBloc, ShoppingState>(builder: (context, state){
            return IngredientsGrid(context, state);
          })

//            SizedBox(height: 10.0,)
        ],
      ),
    );
  }

  void _showMethod(context, servenum) async {
//    print(servenum);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          BlocProvider<DetailRecipeBloc>(
              create: (_) => DetailRecipeBloc(servenum),
              child: MethodScreen(recipe, _defaultServings),
          ),
      )
    );
  }

  Future<void> _showDialog(list, rootContext, rootState) async {
    await showDialog<void>(
        context: rootContext,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<TextFormBloc>(
                create: (_) => TextFormBloc(),
              ),
              BlocProvider<DialogListsBloc>(
                create: (_) => DialogListsBloc(),
              )
            ],
            child: AlertDialog(
              title: Text('Add to shopping list'),
              content:

                  /// if no lists exists
                  BlocBuilder<DialogListsBloc, DialogListsState>(
                      builder: (context, dialogstate) {
                if (dialogstate is DialogStateInitial) {
                  BlocProvider.of<DialogListsBloc>(context)
                      .add(FetchShoppingLists());
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (dialogstate is ShoppingListNotExists) {
                  return BlocBuilder<TextFormBloc, TextFormState>(
                      builder: (context, textstate) {
//                    print((textstate as ListNameState).name);
                    return TextFormField(
                      decoration: InputDecoration(
                        labelText: 'name',
                        errorText: (textstate as ListNameState).name.length == 0
                            ? 'name empty'
                            : null,
                        hintText: 'List created on ' +
                            new DateFormat("yyyy-MM-dd")
                                .format(DateTime.now())
                                .toString(),
                      ),
                      onChanged: (name) =>
                          BlocProvider.of<TextFormBloc>(context)
                              .add(NameChanged(name)),
                    );
                  });
                }
                if (dialogstate is ShoppingListExists) {
//                      print('name');
//                      print(dialogstate.rootLists[0].name);

                  return Column(
                    children: dialogstate.rootLists
                        .map((e) => RadioListTile(
                                title: Text(e.name),
                                value: e.docID,
                                groupValue: dialogstate.docID,
                                onChanged: (value) {
                                  BlocProvider.of<DialogListsBloc>(context).add(
                                      onChanged(dialogstate.rootLists, value));
                                })
//                         FlatButton.icon(onPressed: (){}, icon: Icon(Icons.add), label: Text('add to list'))
                            )
                        .toList(),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              })

              /// if lists exist

              ,
              actions: <Widget>[
                BlocBuilder<DialogListsBloc, DialogListsState>(
                  builder: (context, dialogstate) {
                    if (dialogstate is DialogStateInitial ||
                        dialogstate is LoadingLists) {
                      return Container();
                    }
                    if (dialogstate is ShoppingListExists) {
                      return FlatButton(
                          onPressed: () {
                            BlocProvider.of<DialogListsBloc>(context)
                                .add(CreateListDialogEvent());
                          },
                          child: Text('create shopping list'));
                    }
                    if (dialogstate is ShoppingListNotExists) {
                      return FlatButton(
                          onPressed: () {
                            BlocProvider.of<ShoppingBloc>(rootContext)
                                .add(ClearList());
                            Navigator.pop(context);
                          },
                          child: Text('CANCEL'));
                    }
                    return Container();
                  },
                ),
                BlocBuilder<DialogListsBloc, DialogListsState>(
                  builder: (context, dialogstate) {
                    if (dialogstate is DialogStateInitial ||
                        dialogstate is LoadingLists) {
                      return Container();
                    }

                    if (dialogstate is ShoppingListExists) {
                      return FlatButton(
                        onPressed: () {
                          /// add item to selected list
                          BlocProvider.of<DialogListsBloc>(context).add(
                              AddToListLocal(
                                  rootState.keys, dialogstate.docID, recipe.id)
//                            AddToList(rootState.keys, dialogstate.docID ,widget.recipe.id)

                              );
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      );
                    } else if (dialogstate is ShoppingListNotExists) {
                      return BlocBuilder<TextFormBloc, TextFormState>(
                          builder: (context, innerstate) {
                        return FlatButton(
                            onPressed: (innerstate as ListNameState)
                                        .name
                                        .length ==
                                    0
                                ? null
                                : () {
                                    BlocProvider.of<DialogListsBloc>(context)
                                        .add(CreateListAndAddLocal(
                                                (innerstate as ListNameState)
                                                    .name,
                                                rootState.keys,
                                                recipe.id)
//                                      CreateListAndAdd((innerstate as ListNameState).name, rootState.keys, widget.recipe.id)
                                            );
                                    Navigator.pop(context);
//                            BlocProvider.of<ShoppingBloc>(rootContext).add(AddToList((state as IngredientsState).keys, listid, widget.recipe.id));
                                    /// create and post to list
                                  },
                            child: Text('OK'));
                      });
                    }
                    return Container();
                  },
                ),
              ],
            ),
          );
        }).then((value) => BlocProvider.of<ShoppingBloc>(
            rootContext)
        .add(ClearList()));
  }
}
