import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/resources/repository.dart';
import 'package:recipes/src/blocs/shopping/shopping_event.dart';
import 'package:recipes/src/blocs/shopping/shopping_state.dart';

class ShoppingBloc extends Bloc<ShoppingEvent, ShoppingState> {
  // todo check initial state
  ShoppingBloc() : super(ShoppingInitial());

  Repository _repository = Repository();

  @override
  Stream<ShoppingState> mapEventToState(ShoppingEvent event) async* {

    if (event is SelectIngredient) {
      /// here we must append ingredient to list
      final ingredientList = _repository.addIngredient(event.key);
      yield IngredientSelected(ingredientList);
    }

    if (event is DeselectIngredient) {
      final ingredientList = _repository.removeIngredient(event.key);
      yield IngredientDeselected(ingredientList);
    }

  }

}