// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_tweet.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelTweetAdapter extends TypeAdapter<ModelTweet> {
  @override
  final int typeId = 0;

  @override
  ModelTweet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelTweet(
      profileImage: fields[0] as String?,
      profileName: fields[1] as String?,
      userNameGrey: fields[2] as String?,
      userNameBlue: fields[9] as String?,
      mainTweetText: fields[3] as String?,
      mainTweetImage: fields[4] as String?,
      twitterForAndroid: fields[5] as String?,
      reTweets: fields[6] as String?,
      quoteTweets: fields[7] as String?,
      likesCount: fields[8] as String?,
      time: fields[10] as String?,
      typeReply: fields[11] as String?,
      image: fields[12] as Image?,
    );
  }

  @override
  void write(BinaryWriter writer, ModelTweet obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.profileImage)
      ..writeByte(1)
      ..write(obj.profileName)
      ..writeByte(2)
      ..write(obj.userNameGrey)
      ..writeByte(3)
      ..write(obj.mainTweetText)
      ..writeByte(4)
      ..write(obj.mainTweetImage)
      ..writeByte(5)
      ..write(obj.twitterForAndroid)
      ..writeByte(6)
      ..write(obj.reTweets)
      ..writeByte(7)
      ..write(obj.quoteTweets)
      ..writeByte(8)
      ..write(obj.likesCount)
      ..writeByte(9)
      ..write(obj.userNameBlue)
      ..writeByte(10)
      ..write(obj.time)
      ..writeByte(11)
      ..write(obj.typeReply)
      ..writeByte(12)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelTweetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
