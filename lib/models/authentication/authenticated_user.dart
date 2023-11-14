import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:outt/constants/hive_constants.dart';

part 'authenticated_user.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveConstants.userHiveId)
class AuthenticatedUser {
  @JsonKey(name: 'id')
  @HiveField(0)
  final String? userId;

  @JsonKey(name: 'name')
  @HiveField(1)
  final String? name;

  @JsonKey(name: 'email')
  @HiveField(2)
  final String email;

  @JsonKey(name: 'phone')
  @HiveField(3)
  final String? phone;

  @JsonKey(name: 'token')
  @HiveField(4)
  final String? token;

  @JsonKey(name: 'photo')
  @HiveField(5)
  final String? photoUrl;

  @JsonKey(name: 'signin_provider')
  @HiveField(6)
  final SignInProvider signInProvider;

  @JsonKey(name: 'is_new_user')
  @HiveField(7)
  final bool? isNewUser;

  AuthenticatedUser({
    this.userId,
    this.name,
    required this.email,
    required this.signInProvider,
    this.phone,
    this.token,
    this.photoUrl,
    this.isNewUser,
  });

  //copy Authenticated user and update localProfileImageAsBase64
  AuthenticatedUser copyWith({
    String? userId,
    String? name,
    String? email,
    String? phone,
    String? token,
    String? photoUrl,
    SignInProvider? signInProvider,
    bool? isNewUser,
  }) {
    return AuthenticatedUser(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      token: token ?? this.token,
      photoUrl: photoUrl ?? this.photoUrl,
      signInProvider: signInProvider ?? this.signInProvider,
      isNewUser: isNewUser ?? this.isNewUser,
    );
  }

  factory AuthenticatedUser.fromJson(Map<String, dynamic> json) =>
      _$AuthenticatedUserFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticatedUserToJson(this);
}

@HiveType(typeId: HiveConstants.signInProviderHiveId)
enum SignInProvider {
  @HiveField(0)
  google,
  @HiveField(1)
  facebook,
  @HiveField(2)
  twitter,
  @HiveField(3)
  apple,
}
