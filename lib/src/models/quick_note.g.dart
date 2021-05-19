// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_note.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuickNoteAdapter extends TypeAdapter<QuickNote> {
  @override
  final int typeId = 1;

  @override
  QuickNote read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuickNote(
      content: (fields[0] as List?)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, QuickNote obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.content);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuickNoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
