// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 1;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      id: fields[0] as String?,
      categories: (fields[11] as List).cast<CategoryModel>(),
      categoryId: fields[4] as String,
      isTodayRelease: fields[14] as bool,
      isTopThree: fields[7] as bool,
      title: fields[1] as String,
      description: fields[2] as String,
      imageUrl: fields[3] as String,
      likes: fields[5] as int,
      views: fields[6] as int,
      craftAndCrew: (fields[10] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as Map).cast<String, dynamic>())),
      visibility: fields[8] as bool,
      keywords: (fields[12] as List).cast<dynamic>(),
      timestamp: fields[13] as Timestamp,
      isTrending: fields[9] as bool,
      videoUrl: fields[16] as String,
      trendingImage: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.categoryId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.likes)
      ..writeByte(6)
      ..write(obj.views)
      ..writeByte(7)
      ..write(obj.isTopThree)
      ..writeByte(8)
      ..write(obj.visibility)
      ..writeByte(9)
      ..write(obj.isTrending)
      ..writeByte(10)
      ..write(obj.craftAndCrew)
      ..writeByte(11)
      ..write(obj.categories)
      ..writeByte(12)
      ..write(obj.keywords)
      ..writeByte(13)
      ..write(obj.timestamp)
      ..writeByte(14)
      ..write(obj.isTodayRelease)
      ..writeByte(15)
      ..write(obj.trendingImage)
      ..writeByte(16)
      ..write(obj.videoUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
