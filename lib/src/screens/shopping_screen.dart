import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:recipes/src/blocs/shoppinglist/shoppinglist_bloc.dart';
import 'package:recipes/src/blocs/shoppingscreen/shoppingscreen_bloc.dart';
import 'package:recipes/src/blocs/shoppingscreen/shoppingscreen_event.dart';
import 'package:recipes/src/blocs/shoppingscreen/shoppingscreen_state.dart';
import 'package:recipes/src/blocs/textform/textform_bloc.dart';
import 'package:recipes/src/models/rootlist.dart';
import 'package:recipes/src/screens/editlist_screen.dart';
import 'package:recipes/src/screens/shoppinglist_screen.dart';

class ShoppingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shopping'),),
      body: BlocBuilder<ShoppingScreenBloc, ShoppingScreenState>(
          builder: (rootcontext, state){
            if (state is ShoppingStateInitial) {
              BlocProvider.of<ShoppingScreenBloc>(rootcontext).add(GetRootLists());
              return Center(child: CircularProgressIndicator(),);
            }
            if (state is RootListsNotExist) {
              return Center(child: Text('No shopping lists'),);
            }
            if (state is RootListsExist){
              final List<RootList> rootLists = state.rootLists;
              /// shows root lists
              /// clicking on any opens the contents
              return Column(
                children: rootLists.map((e) =>
                    Card(
                      elevation: 5.0,
                      margin: EdgeInsets.all(10.0),
                      child:
                          InkWell(
                            onTap: () {

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=>
//                                      MultiBlocProvider(
//                                        providers: [
//                                          BlocProvider<ShoppingListBloc>(
//                                            create: (_) => ShoppingListBloc()
//                                          ),
//                                          BlocProvider<ShoppingScreenBloc>(
//                                            create: (_) => BlocProvider.of<ShoppingScreenBloc>(context),
//                                          )
//                                        ],
//                                        child: ShoppingListScreen(e),
//                                      )
                                      BlocProvider(
                                        create: (_) => ShoppingListBloc(),
                                        child: ShoppingListScreen(e, BlocProvider.of<ShoppingScreenBloc>(rootcontext)),
                                      )
                                  )
                              );

                            },
                            child:
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                    Text(DateFormat('dd-MM-yyyy').format(DateTime.parse(e.ctime))),
                                    FlatButton.icon(onPressed: (){

//                                      Navigator.push(context,
//                                          MaterialPageRoute(builder: (context)=>
//                                              EditListScreen(BlocProvider.of<ShoppingScreenBloc>(rootcontext))
//                                          )
//                                      );

                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) =>
                                              MultiBlocProvider(
                                                  providers: [
                                                    BlocProvider<ShoppingListBloc>(
                                                        create: (_) => ShoppingListBloc()
                                                    ),
                                                    BlocProvider<TextFormBloc>(
                                                      create: (_) => TextFormBloc(),
                                                    )
                                                  ],
                                                  child: EditListScreen(e, BlocProvider.of<ShoppingScreenBloc>(rootcontext)),
                                              )
//                                              BlocProvider(
//                                                create: (_) => ShoppingListBloc(),
//                                                child: EditListScreen(e, BlocProvider.of<ShoppingScreenBloc>(rootcontext)),
//                                              )
                                          )
                                      );

                                    }, icon: Icon(Icons.edit), label: SizedBox.shrink())
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5.0),
                                    child: Text(e.name),
                                  )
                                ],
                              ),
                            )
                          )
                      ,)
                ).toList()
              );
            }
            return Container();
          }),
    );
  }


}
