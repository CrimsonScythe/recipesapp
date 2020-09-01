import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/resources/repository.dart';
import 'package:recipes/src/blocs/shopping/shopping_event.dart';
import 'package:recipes/src/blocs/shopping/shopping_state.dart';
import 'package:recipes/src/models/rootlist.dart';
import 'package:tuple/tuple.dart';

class ShoppingBloc extends Bloc<ShoppingEvent, ShoppingState> {
  // todo check initial state
  ShoppingBloc() : super(IngredientsState(new List<Tuple2<dynamic, dynamic>>()));

  Repository _repository = Repository();

  @override
  Stream<ShoppingState> mapEventToState(ShoppingEvent event) async* {

    if (event is SelectIngredient) {
      /// here we must append ingredient to list
//      final ingredientList = _repository.addIngredient(event.key);
//      print(ingredientList);
//      yield IngredientsState(ingredientList);
//      if (state is IngredientsState){
        final lst = (state as IngredientsState).keys;
        lst.add(event.key);
        print(lst);
        yield IngredientsState(lst);
//      } else {
//        var lst=new List<String>();
//        lst.add(event.key);
//        yield IngredientsState(lst);
//      }

    }

    if (event is DeselectIngredient) {
//      final ingredientList = _repository.removeIngredient(event.key);
//      print(ingredientList);
//      yield IngredientsState(ingredientList);
      final lst = (state as IngredientsState).keys;
      lst.remove(event.key);
      print(lst);
      yield IngredientsState(lst);
    }

    if (event is ClearList) {
      yield IngredientsState(new List<Tuple2<dynamic, dynamic>>());
    }

  }

}
