// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoppinglist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShoppingListAdapter extends TypeAdapter<ShoppingList> {
  @override
  final int typeId = 1;

  @override
  ShoppingList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShoppingList(
      fields[0] as String,
      fields[1] as String,
      (fields[2] as List)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, ShoppingList obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj._recipeID)
      ..writeByte(1)
      ..write(obj._ctime)
      ..writeByte(2)
      ..write(obj._ingList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShoppingListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
