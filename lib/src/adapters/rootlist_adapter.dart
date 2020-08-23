//import 'package:hive/hive.dart';
//import 'package:recipes/src/models/rootlist.dart';
//
//class RootListAdapter extends TypeAdapter<RootList> {
//
//  final _typeId = 0;
//
//  @override
//  read(BinaryReader reader) {
//    return RootList(reader.read()[0], _ctime, _name, _shplist)
//  }
//
//  @override
//  int get typeId => _typeId;
//
//  @override
//  void write(BinaryWriter writer, RootList obj) {
//    writer.write(obj.docID);
//    writer.write(obj.ctime);
//    writer.write(obj.name);
//    writer.write(obj.shplist);
//  }
//
//}