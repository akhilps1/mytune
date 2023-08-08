// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryModelAdapter extends TypeAdapter<CategoryModel> {
  @override
  final int typeId = 0;

  @override
  CategoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryModel(
      visibility: fields[1] as bool,
      categoryName: fields[2] as String,
      imageUrl: fields[3] as String,
      timestamp: fields[5] as Timestamp,
      keywords: (fields[6] as List).cast<dynamic>(),
      followers: fields[4] as int,
      isTopTen: fields[8] as bool,
      totalVideos: fields[9] as int?,
      id: fields[0] as String?,
      isCraft: fields[7] as bool,
      totalLikes: fields[10] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.visibility)
      ..writeByte(2)
      ..write(obj.categoryName)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.followers)
      ..writeByte(5)
      ..write(obj.timestamp)
      ..writeByte(6)
      ..write(obj.keywords)
      ..writeByte(7)
      ..write(obj.isCraft)
      ..writeByte(8)
      ..write(obj.isTopTen)
      ..writeByte(9)
      ..write(obj.totalVideos)
      ..writeByte(10)
      ..write(obj.totalLikes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
