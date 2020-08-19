import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/resources/repository.dart';
import 'package:recipes/src/blocs/textform/textform_event.dart';
import 'package:recipes/src/blocs/textform/textform_state.dart';

class TextFormBloc extends Bloc<TextFormEvent, TextFormState> {
  TextFormBloc() : super(ListNameState(''));

  Repository _repository = Repository();

  @override
  Stream<TextFormState> mapEventToState(TextFormEvent event) async* {
    if (event is NameChanged) {
      yield ListNameState(event.name);
    }


  }




}

