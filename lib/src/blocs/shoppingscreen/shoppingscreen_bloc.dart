import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/resources/repository.dart';
import 'package:recipes/src/blocs/shoppingscreen/shoppingscreen_event.dart';
import 'package:recipes/src/blocs/shoppingscreen/shoppingscreen_state.dart';
import 'package:recipes/src/models/rootlist.dart';

class ShoppingScreenBloc extends Bloc<ShoppingScreenEvent, ShoppingScreenState> {
  ShoppingScreenBloc() : super(ShoppingStateInitial());

  Repository _repository = Repository();

  @override
  Stream<ShoppingScreenState> mapEventToState(ShoppingScreenEvent event) async* {
    if (event is GetRootLists) {

      List<RootList> rootLists = await _repository.getShoppingLists(_repository.user.uID);

      if (rootLists==null || rootLists.length==0) {
        yield RootListsNotExist();
      } else {
        yield RootListsExist(rootLists);
      }

    }



  }

}