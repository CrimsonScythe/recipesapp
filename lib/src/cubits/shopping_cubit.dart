import 'package:bloc/bloc.dart';
import 'package:recipes/resources/repository.dart';

class ShoppingCubit extends Cubit<int> {
  ShoppingCubit(int state) : super(state);

  Repository _repository = Repository();


   getShoppingLists() {
    _repository.getShoppingLists(_repository.user.uID);
  }

}