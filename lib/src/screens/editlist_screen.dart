import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/src/blocs/shoppinglist/shoppinglist_bloc.dart';
import 'package:recipes/src/blocs/shoppinglist/shoppinglist_event.dart';
import 'package:recipes/src/blocs/shoppingscreen/shoppingscreen_bloc.dart';
import 'package:recipes/src/blocs/shoppingscreen/shoppingscreen_event.dart';
import 'package:recipes/src/blocs/textform/textform_bloc.dart';
import 'package:recipes/src/blocs/textform/textform_event.dart';
import 'package:recipes/src/blocs/textform/textform_state.dart';
import 'package:recipes/src/models/rootlist.dart';

class EditListScreen extends StatelessWidget {
  final ShoppingScreenBloc _bloc;
  final RootList _rootlist;

  const EditListScreen(this._rootlist, this._bloc);

  @override
  Widget build(BuildContext context) {
    Future<bool> _willPopCallback() async {

      BlocProvider.of<ShoppingListBloc>(context).add(RenameList(_rootlist.docID,
          (BlocProvider.of<TextFormBloc>(context).state as ListNameState).name));

      _bloc.add(RefreshLists());

      return true; // return true if the route to be popped
    }
    return WillPopScope(child:
    Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
        actions: [
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                BlocProvider.of<ShoppingListBloc>(context)
                    .add(DeleteList(_rootlist.docID));
                _bloc.add(RefreshLists());
                Navigator.pop(context);
              })
        ],
      ),
      body: Container(
        child: Column(
          children: [
            BlocBuilder<TextFormBloc, TextFormState>(
                builder: (context, textstate) {
                  print((textstate as ListNameState).name);
                  return
                    Container(
                      margin: EdgeInsets.all(15.0),
                      child:
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderSide: BorderSide()),
                            labelText: 'List name',
                            errorText: (textstate as ListNameState).name.length == 0
                                ? 'name empty'
                                : null,
                            hintText: 'list1...'),
                        onChanged: (name) => BlocProvider.of<TextFormBloc>(context)
                            .add(NameChanged(name)),
                      ),
                    );

                })
          ],
        ),
      ),
    )
        , onWillPop: _willPopCallback);

  }

}
