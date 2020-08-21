import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:recipes/src/blocs/shoppinglist/shoppinglist_bloc.dart';
import 'package:recipes/src/blocs/shoppingscreen/shoppingscreen_bloc.dart';
import 'package:recipes/src/blocs/shoppingscreen/shoppingscreen_event.dart';
import 'package:recipes/src/blocs/shoppingscreen/shoppingscreen_state.dart';
import 'package:recipes/src/models/rootlist.dart';
import 'package:recipes/src/screens/shoppinglist_screen.dart';

class ShoppingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shopping'),),
      body: BlocBuilder<ShoppingScreenBloc, ShoppingScreenState>(
          builder: (context, state){
            if (state is ShoppingStateInitial) {
              BlocProvider.of<ShoppingScreenBloc>(context).add(GetRootLists());
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
                                      BlocProvider(create: (_) => ShoppingListBloc(),
                                        child: ShoppingListScreen(e),
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
                                    Text(DateFormat('dd-MM-yyyy').format(e.ctime.toDate())),
                                    FlatButton.icon(onPressed: (){}, icon: Icon(Icons.edit), label: SizedBox.shrink())
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
