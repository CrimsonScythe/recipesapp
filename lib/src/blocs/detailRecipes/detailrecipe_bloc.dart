import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/src/blocs/detailRecipes/detailrecipe_event.dart';
import 'package:recipes/src/blocs/detailRecipes/detailrecipe_state.dart';


class DetailRecipeBloc extends Bloc<DetailRecipeEvent, int> {
  DetailRecipeBloc(initialState) : super(initialState);

  @override
  Stream<int> mapEventToState(DetailRecipeEvent event) async* {
    if (event is Increment) {
      yield state+1;
    }
    if (event is Decrement) {
      yield (state == 1)? state:state-1;
    }
  }


}
