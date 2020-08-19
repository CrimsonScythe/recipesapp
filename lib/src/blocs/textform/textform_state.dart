import 'package:recipes/src/models/rootlist.dart';
//todo: Equatable?
abstract class TextFormState {
  const TextFormState();
}

class ListNameState extends TextFormState {

  final String name;

  ListNameState(this.name);

}



