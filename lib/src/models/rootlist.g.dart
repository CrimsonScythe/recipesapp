// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rootlist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RootListAdapter extends TypeAdapter<RootList> {
  @override
  final int typeId = 0;

  @override
  RootList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RootList(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      (fields[3] as List)?.cast<ShoppingList>(),
    );
  }

  @override
  void write(BinaryWriter writer, RootList obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj._docID)
      ..writeByte(1)
      ..write(obj._ctime)
      ..writeByte(2)
      ..write(obj._name)
      ..writeByte(3)
      ..write(obj._shplist);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RootListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
