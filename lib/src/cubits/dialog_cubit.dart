import 'package:flutter_bloc/flutter_bloc.dart';

class DialogCubit extends Cubit<String> {
  DialogCubit(String state) : super(state);

  void changedName(name) => emit(name);

}