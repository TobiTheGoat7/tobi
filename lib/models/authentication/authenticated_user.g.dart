// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authenticated_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthenticatedUserAdapter extends TypeAdapter<AuthenticatedUser> {
  @override
  final int typeId = 1;

  @override
  AuthenticatedUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthenticatedUser(
      userId: fields[0] as String?,
      name: fields[1] as String?,
      email: fields[2] as String,
      signInProvider: fields[6] as SignInProvider,
      phone: fields[3] as String?,
      token: fields[4] as String?,
      photoUrl: fields[5] as String?,
      isNewUser: fields[7] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, AuthenticatedUser obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.token)
      ..writeByte(5)
      ..write(obj.photoUrl)
      ..writeByte(6)
      ..write(obj.signInProvider)
      ..writeByte(7)
      ..write(obj.isNewUser);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthenticatedUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SignInProviderAdapter extends TypeAdapter<SignInProvider> {
  @override
  final int typeId = 2;

  @override
  SignInProvider read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SignInProvider.google;
      case 1:
        return SignInProvider.facebook;
      case 2:
        return SignInProvider.twitter;
      case 3:
        return SignInProvider.apple;
      default:
        return SignInProvider.google;
    }
  }

  @override
  void write(BinaryWriter writer, SignInProvider obj) {
    switch (obj) {
      case SignInProvider.google:
        writer.writeByte(0);
        break;
      case SignInProvider.facebook:
        writer.writeByte(1);
        break;
      case SignInProvider.twitter:
        writer.writeByte(2);
        break;
      case SignInProvider.apple:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignInProviderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticatedUser _$AuthenticatedUserFromJson(Map<String, dynamic> json) =>
    AuthenticatedUser(
      userId: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String,
      signInProvider:
          $enumDecode(_$SignInProviderEnumMap, json['signin_provider']),
      phone: json['phone'] as String?,
      token: json['token'] as String?,
      photoUrl: json['photo'] as String?,
      isNewUser: json['is_new_user'] as bool?,
    );

Map<String, dynamic> _$AuthenticatedUserToJson(AuthenticatedUser instance) =>
    <String, dynamic>{
      'id': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'token': instance.token,
      'photo': instance.photoUrl,
      'signin_provider': _$SignInProviderEnumMap[instance.signInProvider]!,
      'is_new_user': instance.isNewUser,
    };

const _$SignInProviderEnumMap = {
  SignInProvider.google: 'google',
  SignInProvider.facebook: 'facebook',
  SignInProvider.twitter: 'twitter',
  SignInProvider.apple: 'apple',
};
