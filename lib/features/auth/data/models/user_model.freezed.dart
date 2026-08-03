// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserModel {

 String get uid; String get email; String get displayName; String get photoUrl; String get bio; String? get phoneNumber; String get username; String get location; String get website; String? get githubUsername; String? get resumeUrl; List<String> get interests; List<String> get technologies; List<String> get socialLinks; CareerGoal? get careerGoal; ExperienceLevel? get experienceLevel; bool get isEmailVerified; bool get isProfileComplete; bool get isOnboarded; bool get isGithubConnected; bool get hasResume;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;@JsonKey(name: 'last_login_at') DateTime? get lastLoginAt;
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserModelCopyWith<UserModel> get copyWith => _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserModel&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.username, username) || other.username == username)&&(identical(other.location, location) || other.location == location)&&(identical(other.website, website) || other.website == website)&&(identical(other.githubUsername, githubUsername) || other.githubUsername == githubUsername)&&(identical(other.resumeUrl, resumeUrl) || other.resumeUrl == resumeUrl)&&const DeepCollectionEquality().equals(other.interests, interests)&&const DeepCollectionEquality().equals(other.technologies, technologies)&&const DeepCollectionEquality().equals(other.socialLinks, socialLinks)&&(identical(other.careerGoal, careerGoal) || other.careerGoal == careerGoal)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&(identical(other.isEmailVerified, isEmailVerified) || other.isEmailVerified == isEmailVerified)&&(identical(other.isProfileComplete, isProfileComplete) || other.isProfileComplete == isProfileComplete)&&(identical(other.isOnboarded, isOnboarded) || other.isOnboarded == isOnboarded)&&(identical(other.isGithubConnected, isGithubConnected) || other.isGithubConnected == isGithubConnected)&&(identical(other.hasResume, hasResume) || other.hasResume == hasResume)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastLoginAt, lastLoginAt) || other.lastLoginAt == lastLoginAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,uid,email,displayName,photoUrl,bio,phoneNumber,username,location,website,githubUsername,resumeUrl,const DeepCollectionEquality().hash(interests),const DeepCollectionEquality().hash(technologies),const DeepCollectionEquality().hash(socialLinks),careerGoal,experienceLevel,isEmailVerified,isProfileComplete,isOnboarded,isGithubConnected,hasResume,createdAt,updatedAt,lastLoginAt]);

@override
String toString() {
  return 'UserModel(uid: $uid, email: $email, displayName: $displayName, photoUrl: $photoUrl, bio: $bio, phoneNumber: $phoneNumber, username: $username, location: $location, website: $website, githubUsername: $githubUsername, resumeUrl: $resumeUrl, interests: $interests, technologies: $technologies, socialLinks: $socialLinks, careerGoal: $careerGoal, experienceLevel: $experienceLevel, isEmailVerified: $isEmailVerified, isProfileComplete: $isProfileComplete, isOnboarded: $isOnboarded, isGithubConnected: $isGithubConnected, hasResume: $hasResume, createdAt: $createdAt, updatedAt: $updatedAt, lastLoginAt: $lastLoginAt)';
}


}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res>  {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) = _$UserModelCopyWithImpl;
@useResult
$Res call({
 String uid, String email, String displayName, String photoUrl, String bio, String? phoneNumber, String username, String location, String website, String? githubUsername, String? resumeUrl, List<String> interests, List<String> technologies, List<String> socialLinks, CareerGoal? careerGoal, ExperienceLevel? experienceLevel, bool isEmailVerified, bool isProfileComplete, bool isOnboarded, bool isGithubConnected, bool hasResume,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt,@JsonKey(name: 'last_login_at') DateTime? lastLoginAt
});




}
/// @nodoc
class _$UserModelCopyWithImpl<$Res>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? email = null,Object? displayName = null,Object? photoUrl = null,Object? bio = null,Object? phoneNumber = freezed,Object? username = null,Object? location = null,Object? website = null,Object? githubUsername = freezed,Object? resumeUrl = freezed,Object? interests = null,Object? technologies = null,Object? socialLinks = null,Object? careerGoal = freezed,Object? experienceLevel = freezed,Object? isEmailVerified = null,Object? isProfileComplete = null,Object? isOnboarded = null,Object? isGithubConnected = null,Object? hasResume = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? lastLoginAt = freezed,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,website: null == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String,githubUsername: freezed == githubUsername ? _self.githubUsername : githubUsername // ignore: cast_nullable_to_non_nullable
as String?,resumeUrl: freezed == resumeUrl ? _self.resumeUrl : resumeUrl // ignore: cast_nullable_to_non_nullable
as String?,interests: null == interests ? _self.interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>,technologies: null == technologies ? _self.technologies : technologies // ignore: cast_nullable_to_non_nullable
as List<String>,socialLinks: null == socialLinks ? _self.socialLinks : socialLinks // ignore: cast_nullable_to_non_nullable
as List<String>,careerGoal: freezed == careerGoal ? _self.careerGoal : careerGoal // ignore: cast_nullable_to_non_nullable
as CareerGoal?,experienceLevel: freezed == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as ExperienceLevel?,isEmailVerified: null == isEmailVerified ? _self.isEmailVerified : isEmailVerified // ignore: cast_nullable_to_non_nullable
as bool,isProfileComplete: null == isProfileComplete ? _self.isProfileComplete : isProfileComplete // ignore: cast_nullable_to_non_nullable
as bool,isOnboarded: null == isOnboarded ? _self.isOnboarded : isOnboarded // ignore: cast_nullable_to_non_nullable
as bool,isGithubConnected: null == isGithubConnected ? _self.isGithubConnected : isGithubConnected // ignore: cast_nullable_to_non_nullable
as bool,hasResume: null == hasResume ? _self.hasResume : hasResume // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastLoginAt: freezed == lastLoginAt ? _self.lastLoginAt : lastLoginAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserModel].
extension UserModelPatterns on UserModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserModel value)  $default,){
final _that = this;
switch (_that) {
case _UserModel():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  String email,  String displayName,  String photoUrl,  String bio,  String? phoneNumber,  String username,  String location,  String website,  String? githubUsername,  String? resumeUrl,  List<String> interests,  List<String> technologies,  List<String> socialLinks,  CareerGoal? careerGoal,  ExperienceLevel? experienceLevel,  bool isEmailVerified,  bool isProfileComplete,  bool isOnboarded,  bool isGithubConnected,  bool hasResume, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(name: 'last_login_at')  DateTime? lastLoginAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.uid,_that.email,_that.displayName,_that.photoUrl,_that.bio,_that.phoneNumber,_that.username,_that.location,_that.website,_that.githubUsername,_that.resumeUrl,_that.interests,_that.technologies,_that.socialLinks,_that.careerGoal,_that.experienceLevel,_that.isEmailVerified,_that.isProfileComplete,_that.isOnboarded,_that.isGithubConnected,_that.hasResume,_that.createdAt,_that.updatedAt,_that.lastLoginAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  String email,  String displayName,  String photoUrl,  String bio,  String? phoneNumber,  String username,  String location,  String website,  String? githubUsername,  String? resumeUrl,  List<String> interests,  List<String> technologies,  List<String> socialLinks,  CareerGoal? careerGoal,  ExperienceLevel? experienceLevel,  bool isEmailVerified,  bool isProfileComplete,  bool isOnboarded,  bool isGithubConnected,  bool hasResume, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(name: 'last_login_at')  DateTime? lastLoginAt)  $default,) {final _that = this;
switch (_that) {
case _UserModel():
return $default(_that.uid,_that.email,_that.displayName,_that.photoUrl,_that.bio,_that.phoneNumber,_that.username,_that.location,_that.website,_that.githubUsername,_that.resumeUrl,_that.interests,_that.technologies,_that.socialLinks,_that.careerGoal,_that.experienceLevel,_that.isEmailVerified,_that.isProfileComplete,_that.isOnboarded,_that.isGithubConnected,_that.hasResume,_that.createdAt,_that.updatedAt,_that.lastLoginAt);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  String email,  String displayName,  String photoUrl,  String bio,  String? phoneNumber,  String username,  String location,  String website,  String? githubUsername,  String? resumeUrl,  List<String> interests,  List<String> technologies,  List<String> socialLinks,  CareerGoal? careerGoal,  ExperienceLevel? experienceLevel,  bool isEmailVerified,  bool isProfileComplete,  bool isOnboarded,  bool isGithubConnected,  bool hasResume, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(name: 'last_login_at')  DateTime? lastLoginAt)?  $default,) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.uid,_that.email,_that.displayName,_that.photoUrl,_that.bio,_that.phoneNumber,_that.username,_that.location,_that.website,_that.githubUsername,_that.resumeUrl,_that.interests,_that.technologies,_that.socialLinks,_that.careerGoal,_that.experienceLevel,_that.isEmailVerified,_that.isProfileComplete,_that.isOnboarded,_that.isGithubConnected,_that.hasResume,_that.createdAt,_that.updatedAt,_that.lastLoginAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserModel implements UserModel {
  const _UserModel({required this.uid, required this.email, this.displayName = '', this.photoUrl = '', this.bio = '', this.phoneNumber, this.username = '', this.location = '', this.website = '', this.githubUsername, this.resumeUrl, final  List<String> interests = const [], final  List<String> technologies = const [], final  List<String> socialLinks = const [], this.careerGoal, this.experienceLevel, this.isEmailVerified = false, this.isProfileComplete = false, this.isOnboarded = false, this.isGithubConnected = false, this.hasResume = false, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt, @JsonKey(name: 'last_login_at') this.lastLoginAt}): _interests = interests,_technologies = technologies,_socialLinks = socialLinks;
  factory _UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

@override final  String uid;
@override final  String email;
@override@JsonKey() final  String displayName;
@override@JsonKey() final  String photoUrl;
@override@JsonKey() final  String bio;
@override final  String? phoneNumber;
@override@JsonKey() final  String username;
@override@JsonKey() final  String location;
@override@JsonKey() final  String website;
@override final  String? githubUsername;
@override final  String? resumeUrl;
 final  List<String> _interests;
@override@JsonKey() List<String> get interests {
  if (_interests is EqualUnmodifiableListView) return _interests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_interests);
}

 final  List<String> _technologies;
@override@JsonKey() List<String> get technologies {
  if (_technologies is EqualUnmodifiableListView) return _technologies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_technologies);
}

 final  List<String> _socialLinks;
@override@JsonKey() List<String> get socialLinks {
  if (_socialLinks is EqualUnmodifiableListView) return _socialLinks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_socialLinks);
}

@override final  CareerGoal? careerGoal;
@override final  ExperienceLevel? experienceLevel;
@override@JsonKey() final  bool isEmailVerified;
@override@JsonKey() final  bool isProfileComplete;
@override@JsonKey() final  bool isOnboarded;
@override@JsonKey() final  bool isGithubConnected;
@override@JsonKey() final  bool hasResume;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;
@override@JsonKey(name: 'last_login_at') final  DateTime? lastLoginAt;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserModelCopyWith<_UserModel> get copyWith => __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserModel&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.username, username) || other.username == username)&&(identical(other.location, location) || other.location == location)&&(identical(other.website, website) || other.website == website)&&(identical(other.githubUsername, githubUsername) || other.githubUsername == githubUsername)&&(identical(other.resumeUrl, resumeUrl) || other.resumeUrl == resumeUrl)&&const DeepCollectionEquality().equals(other._interests, _interests)&&const DeepCollectionEquality().equals(other._technologies, _technologies)&&const DeepCollectionEquality().equals(other._socialLinks, _socialLinks)&&(identical(other.careerGoal, careerGoal) || other.careerGoal == careerGoal)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&(identical(other.isEmailVerified, isEmailVerified) || other.isEmailVerified == isEmailVerified)&&(identical(other.isProfileComplete, isProfileComplete) || other.isProfileComplete == isProfileComplete)&&(identical(other.isOnboarded, isOnboarded) || other.isOnboarded == isOnboarded)&&(identical(other.isGithubConnected, isGithubConnected) || other.isGithubConnected == isGithubConnected)&&(identical(other.hasResume, hasResume) || other.hasResume == hasResume)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastLoginAt, lastLoginAt) || other.lastLoginAt == lastLoginAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,uid,email,displayName,photoUrl,bio,phoneNumber,username,location,website,githubUsername,resumeUrl,const DeepCollectionEquality().hash(_interests),const DeepCollectionEquality().hash(_technologies),const DeepCollectionEquality().hash(_socialLinks),careerGoal,experienceLevel,isEmailVerified,isProfileComplete,isOnboarded,isGithubConnected,hasResume,createdAt,updatedAt,lastLoginAt]);

@override
String toString() {
  return 'UserModel(uid: $uid, email: $email, displayName: $displayName, photoUrl: $photoUrl, bio: $bio, phoneNumber: $phoneNumber, username: $username, location: $location, website: $website, githubUsername: $githubUsername, resumeUrl: $resumeUrl, interests: $interests, technologies: $technologies, socialLinks: $socialLinks, careerGoal: $careerGoal, experienceLevel: $experienceLevel, isEmailVerified: $isEmailVerified, isProfileComplete: $isProfileComplete, isOnboarded: $isOnboarded, isGithubConnected: $isGithubConnected, hasResume: $hasResume, createdAt: $createdAt, updatedAt: $updatedAt, lastLoginAt: $lastLoginAt)';
}


}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(_UserModel value, $Res Function(_UserModel) _then) = __$UserModelCopyWithImpl;
@override @useResult
$Res call({
 String uid, String email, String displayName, String photoUrl, String bio, String? phoneNumber, String username, String location, String website, String? githubUsername, String? resumeUrl, List<String> interests, List<String> technologies, List<String> socialLinks, CareerGoal? careerGoal, ExperienceLevel? experienceLevel, bool isEmailVerified, bool isProfileComplete, bool isOnboarded, bool isGithubConnected, bool hasResume,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt,@JsonKey(name: 'last_login_at') DateTime? lastLoginAt
});




}
/// @nodoc
class __$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? email = null,Object? displayName = null,Object? photoUrl = null,Object? bio = null,Object? phoneNumber = freezed,Object? username = null,Object? location = null,Object? website = null,Object? githubUsername = freezed,Object? resumeUrl = freezed,Object? interests = null,Object? technologies = null,Object? socialLinks = null,Object? careerGoal = freezed,Object? experienceLevel = freezed,Object? isEmailVerified = null,Object? isProfileComplete = null,Object? isOnboarded = null,Object? isGithubConnected = null,Object? hasResume = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? lastLoginAt = freezed,}) {
  return _then(_UserModel(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,website: null == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String,githubUsername: freezed == githubUsername ? _self.githubUsername : githubUsername // ignore: cast_nullable_to_non_nullable
as String?,resumeUrl: freezed == resumeUrl ? _self.resumeUrl : resumeUrl // ignore: cast_nullable_to_non_nullable
as String?,interests: null == interests ? _self._interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>,technologies: null == technologies ? _self._technologies : technologies // ignore: cast_nullable_to_non_nullable
as List<String>,socialLinks: null == socialLinks ? _self._socialLinks : socialLinks // ignore: cast_nullable_to_non_nullable
as List<String>,careerGoal: freezed == careerGoal ? _self.careerGoal : careerGoal // ignore: cast_nullable_to_non_nullable
as CareerGoal?,experienceLevel: freezed == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as ExperienceLevel?,isEmailVerified: null == isEmailVerified ? _self.isEmailVerified : isEmailVerified // ignore: cast_nullable_to_non_nullable
as bool,isProfileComplete: null == isProfileComplete ? _self.isProfileComplete : isProfileComplete // ignore: cast_nullable_to_non_nullable
as bool,isOnboarded: null == isOnboarded ? _self.isOnboarded : isOnboarded // ignore: cast_nullable_to_non_nullable
as bool,isGithubConnected: null == isGithubConnected ? _self.isGithubConnected : isGithubConnected // ignore: cast_nullable_to_non_nullable
as bool,hasResume: null == hasResume ? _self.hasResume : hasResume // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastLoginAt: freezed == lastLoginAt ? _self.lastLoginAt : lastLoginAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
