// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthFailure {

 String get message;
/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthFailureCopyWith<AuthFailure> get copyWith => _$AuthFailureCopyWithImpl<AuthFailure>(this as AuthFailure, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthFailure(message: $message)';
}


}

/// @nodoc
abstract mixin class $AuthFailureCopyWith<$Res>  {
  factory $AuthFailureCopyWith(AuthFailure value, $Res Function(AuthFailure) _then) = _$AuthFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$AuthFailureCopyWithImpl<$Res>
    implements $AuthFailureCopyWith<$Res> {
  _$AuthFailureCopyWithImpl(this._self, this._then);

  final AuthFailure _self;
  final $Res Function(AuthFailure) _then;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthFailure].
extension AuthFailurePatterns on AuthFailure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InvalidEmailFailure value)?  invalidEmail,TResult Function( InvalidCredentialsFailure value)?  invalidCredentials,TResult Function( EmailAlreadyInUseFailure value)?  emailAlreadyInUse,TResult Function( WeakPasswordFailure value)?  weakPassword,TResult Function( EmailNotConfirmedFailure value)?  emailNotConfirmed,TResult Function( UserNotFoundFailure value)?  userNotFound,TResult Function( NetworkFailure value)?  network,TResult Function( SessionExpiredFailure value)?  sessionExpired,TResult Function( UnknownAuthFailure value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InvalidEmailFailure() when invalidEmail != null:
return invalidEmail(_that);case InvalidCredentialsFailure() when invalidCredentials != null:
return invalidCredentials(_that);case EmailAlreadyInUseFailure() when emailAlreadyInUse != null:
return emailAlreadyInUse(_that);case WeakPasswordFailure() when weakPassword != null:
return weakPassword(_that);case EmailNotConfirmedFailure() when emailNotConfirmed != null:
return emailNotConfirmed(_that);case UserNotFoundFailure() when userNotFound != null:
return userNotFound(_that);case NetworkFailure() when network != null:
return network(_that);case SessionExpiredFailure() when sessionExpired != null:
return sessionExpired(_that);case UnknownAuthFailure() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InvalidEmailFailure value)  invalidEmail,required TResult Function( InvalidCredentialsFailure value)  invalidCredentials,required TResult Function( EmailAlreadyInUseFailure value)  emailAlreadyInUse,required TResult Function( WeakPasswordFailure value)  weakPassword,required TResult Function( EmailNotConfirmedFailure value)  emailNotConfirmed,required TResult Function( UserNotFoundFailure value)  userNotFound,required TResult Function( NetworkFailure value)  network,required TResult Function( SessionExpiredFailure value)  sessionExpired,required TResult Function( UnknownAuthFailure value)  unknown,}){
final _that = this;
switch (_that) {
case InvalidEmailFailure():
return invalidEmail(_that);case InvalidCredentialsFailure():
return invalidCredentials(_that);case EmailAlreadyInUseFailure():
return emailAlreadyInUse(_that);case WeakPasswordFailure():
return weakPassword(_that);case EmailNotConfirmedFailure():
return emailNotConfirmed(_that);case UserNotFoundFailure():
return userNotFound(_that);case NetworkFailure():
return network(_that);case SessionExpiredFailure():
return sessionExpired(_that);case UnknownAuthFailure():
return unknown(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InvalidEmailFailure value)?  invalidEmail,TResult? Function( InvalidCredentialsFailure value)?  invalidCredentials,TResult? Function( EmailAlreadyInUseFailure value)?  emailAlreadyInUse,TResult? Function( WeakPasswordFailure value)?  weakPassword,TResult? Function( EmailNotConfirmedFailure value)?  emailNotConfirmed,TResult? Function( UserNotFoundFailure value)?  userNotFound,TResult? Function( NetworkFailure value)?  network,TResult? Function( SessionExpiredFailure value)?  sessionExpired,TResult? Function( UnknownAuthFailure value)?  unknown,}){
final _that = this;
switch (_that) {
case InvalidEmailFailure() when invalidEmail != null:
return invalidEmail(_that);case InvalidCredentialsFailure() when invalidCredentials != null:
return invalidCredentials(_that);case EmailAlreadyInUseFailure() when emailAlreadyInUse != null:
return emailAlreadyInUse(_that);case WeakPasswordFailure() when weakPassword != null:
return weakPassword(_that);case EmailNotConfirmedFailure() when emailNotConfirmed != null:
return emailNotConfirmed(_that);case UserNotFoundFailure() when userNotFound != null:
return userNotFound(_that);case NetworkFailure() when network != null:
return network(_that);case SessionExpiredFailure() when sessionExpired != null:
return sessionExpired(_that);case UnknownAuthFailure() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message)?  invalidEmail,TResult Function( String message)?  invalidCredentials,TResult Function( String message)?  emailAlreadyInUse,TResult Function( String message)?  weakPassword,TResult Function( String email,  String message)?  emailNotConfirmed,TResult Function( String message)?  userNotFound,TResult Function( String message)?  network,TResult Function( String message)?  sessionExpired,TResult Function( String message)?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InvalidEmailFailure() when invalidEmail != null:
return invalidEmail(_that.message);case InvalidCredentialsFailure() when invalidCredentials != null:
return invalidCredentials(_that.message);case EmailAlreadyInUseFailure() when emailAlreadyInUse != null:
return emailAlreadyInUse(_that.message);case WeakPasswordFailure() when weakPassword != null:
return weakPassword(_that.message);case EmailNotConfirmedFailure() when emailNotConfirmed != null:
return emailNotConfirmed(_that.email,_that.message);case UserNotFoundFailure() when userNotFound != null:
return userNotFound(_that.message);case NetworkFailure() when network != null:
return network(_that.message);case SessionExpiredFailure() when sessionExpired != null:
return sessionExpired(_that.message);case UnknownAuthFailure() when unknown != null:
return unknown(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message)  invalidEmail,required TResult Function( String message)  invalidCredentials,required TResult Function( String message)  emailAlreadyInUse,required TResult Function( String message)  weakPassword,required TResult Function( String email,  String message)  emailNotConfirmed,required TResult Function( String message)  userNotFound,required TResult Function( String message)  network,required TResult Function( String message)  sessionExpired,required TResult Function( String message)  unknown,}) {final _that = this;
switch (_that) {
case InvalidEmailFailure():
return invalidEmail(_that.message);case InvalidCredentialsFailure():
return invalidCredentials(_that.message);case EmailAlreadyInUseFailure():
return emailAlreadyInUse(_that.message);case WeakPasswordFailure():
return weakPassword(_that.message);case EmailNotConfirmedFailure():
return emailNotConfirmed(_that.email,_that.message);case UserNotFoundFailure():
return userNotFound(_that.message);case NetworkFailure():
return network(_that.message);case SessionExpiredFailure():
return sessionExpired(_that.message);case UnknownAuthFailure():
return unknown(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message)?  invalidEmail,TResult? Function( String message)?  invalidCredentials,TResult? Function( String message)?  emailAlreadyInUse,TResult? Function( String message)?  weakPassword,TResult? Function( String email,  String message)?  emailNotConfirmed,TResult? Function( String message)?  userNotFound,TResult? Function( String message)?  network,TResult? Function( String message)?  sessionExpired,TResult? Function( String message)?  unknown,}) {final _that = this;
switch (_that) {
case InvalidEmailFailure() when invalidEmail != null:
return invalidEmail(_that.message);case InvalidCredentialsFailure() when invalidCredentials != null:
return invalidCredentials(_that.message);case EmailAlreadyInUseFailure() when emailAlreadyInUse != null:
return emailAlreadyInUse(_that.message);case WeakPasswordFailure() when weakPassword != null:
return weakPassword(_that.message);case EmailNotConfirmedFailure() when emailNotConfirmed != null:
return emailNotConfirmed(_that.email,_that.message);case UserNotFoundFailure() when userNotFound != null:
return userNotFound(_that.message);case NetworkFailure() when network != null:
return network(_that.message);case SessionExpiredFailure() when sessionExpired != null:
return sessionExpired(_that.message);case UnknownAuthFailure() when unknown != null:
return unknown(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class InvalidEmailFailure implements AuthFailure {
  const InvalidEmailFailure({this.message = 'Please enter a valid email address.'});
  

@override@JsonKey() final  String message;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvalidEmailFailureCopyWith<InvalidEmailFailure> get copyWith => _$InvalidEmailFailureCopyWithImpl<InvalidEmailFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidEmailFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthFailure.invalidEmail(message: $message)';
}


}

/// @nodoc
abstract mixin class $InvalidEmailFailureCopyWith<$Res> implements $AuthFailureCopyWith<$Res> {
  factory $InvalidEmailFailureCopyWith(InvalidEmailFailure value, $Res Function(InvalidEmailFailure) _then) = _$InvalidEmailFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$InvalidEmailFailureCopyWithImpl<$Res>
    implements $InvalidEmailFailureCopyWith<$Res> {
  _$InvalidEmailFailureCopyWithImpl(this._self, this._then);

  final InvalidEmailFailure _self;
  final $Res Function(InvalidEmailFailure) _then;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(InvalidEmailFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class InvalidCredentialsFailure implements AuthFailure {
  const InvalidCredentialsFailure({this.message = 'The email or password you entered is incorrect.'});
  

@override@JsonKey() final  String message;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvalidCredentialsFailureCopyWith<InvalidCredentialsFailure> get copyWith => _$InvalidCredentialsFailureCopyWithImpl<InvalidCredentialsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidCredentialsFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthFailure.invalidCredentials(message: $message)';
}


}

/// @nodoc
abstract mixin class $InvalidCredentialsFailureCopyWith<$Res> implements $AuthFailureCopyWith<$Res> {
  factory $InvalidCredentialsFailureCopyWith(InvalidCredentialsFailure value, $Res Function(InvalidCredentialsFailure) _then) = _$InvalidCredentialsFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$InvalidCredentialsFailureCopyWithImpl<$Res>
    implements $InvalidCredentialsFailureCopyWith<$Res> {
  _$InvalidCredentialsFailureCopyWithImpl(this._self, this._then);

  final InvalidCredentialsFailure _self;
  final $Res Function(InvalidCredentialsFailure) _then;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(InvalidCredentialsFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class EmailAlreadyInUseFailure implements AuthFailure {
  const EmailAlreadyInUseFailure({this.message = 'An account with this email already exists.'});
  

@override@JsonKey() final  String message;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailAlreadyInUseFailureCopyWith<EmailAlreadyInUseFailure> get copyWith => _$EmailAlreadyInUseFailureCopyWithImpl<EmailAlreadyInUseFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailAlreadyInUseFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthFailure.emailAlreadyInUse(message: $message)';
}


}

/// @nodoc
abstract mixin class $EmailAlreadyInUseFailureCopyWith<$Res> implements $AuthFailureCopyWith<$Res> {
  factory $EmailAlreadyInUseFailureCopyWith(EmailAlreadyInUseFailure value, $Res Function(EmailAlreadyInUseFailure) _then) = _$EmailAlreadyInUseFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$EmailAlreadyInUseFailureCopyWithImpl<$Res>
    implements $EmailAlreadyInUseFailureCopyWith<$Res> {
  _$EmailAlreadyInUseFailureCopyWithImpl(this._self, this._then);

  final EmailAlreadyInUseFailure _self;
  final $Res Function(EmailAlreadyInUseFailure) _then;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(EmailAlreadyInUseFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class WeakPasswordFailure implements AuthFailure {
  const WeakPasswordFailure({this.message = 'The password is too weak.'});
  

@override@JsonKey() final  String message;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeakPasswordFailureCopyWith<WeakPasswordFailure> get copyWith => _$WeakPasswordFailureCopyWithImpl<WeakPasswordFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeakPasswordFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthFailure.weakPassword(message: $message)';
}


}

/// @nodoc
abstract mixin class $WeakPasswordFailureCopyWith<$Res> implements $AuthFailureCopyWith<$Res> {
  factory $WeakPasswordFailureCopyWith(WeakPasswordFailure value, $Res Function(WeakPasswordFailure) _then) = _$WeakPasswordFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$WeakPasswordFailureCopyWithImpl<$Res>
    implements $WeakPasswordFailureCopyWith<$Res> {
  _$WeakPasswordFailureCopyWithImpl(this._self, this._then);

  final WeakPasswordFailure _self;
  final $Res Function(WeakPasswordFailure) _then;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(WeakPasswordFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class EmailNotConfirmedFailure implements AuthFailure {
  const EmailNotConfirmedFailure({required this.email, this.message = 'Please verify your email address to continue.'});
  

 final  String email;
@override@JsonKey() final  String message;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailNotConfirmedFailureCopyWith<EmailNotConfirmedFailure> get copyWith => _$EmailNotConfirmedFailureCopyWithImpl<EmailNotConfirmedFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailNotConfirmedFailure&&(identical(other.email, email) || other.email == email)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,email,message);

@override
String toString() {
  return 'AuthFailure.emailNotConfirmed(email: $email, message: $message)';
}


}

/// @nodoc
abstract mixin class $EmailNotConfirmedFailureCopyWith<$Res> implements $AuthFailureCopyWith<$Res> {
  factory $EmailNotConfirmedFailureCopyWith(EmailNotConfirmedFailure value, $Res Function(EmailNotConfirmedFailure) _then) = _$EmailNotConfirmedFailureCopyWithImpl;
@override @useResult
$Res call({
 String email, String message
});




}
/// @nodoc
class _$EmailNotConfirmedFailureCopyWithImpl<$Res>
    implements $EmailNotConfirmedFailureCopyWith<$Res> {
  _$EmailNotConfirmedFailureCopyWithImpl(this._self, this._then);

  final EmailNotConfirmedFailure _self;
  final $Res Function(EmailNotConfirmedFailure) _then;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? message = null,}) {
  return _then(EmailNotConfirmedFailure(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class UserNotFoundFailure implements AuthFailure {
  const UserNotFoundFailure({this.message = 'No account found with this email address.'});
  

@override@JsonKey() final  String message;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserNotFoundFailureCopyWith<UserNotFoundFailure> get copyWith => _$UserNotFoundFailureCopyWithImpl<UserNotFoundFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserNotFoundFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthFailure.userNotFound(message: $message)';
}


}

/// @nodoc
abstract mixin class $UserNotFoundFailureCopyWith<$Res> implements $AuthFailureCopyWith<$Res> {
  factory $UserNotFoundFailureCopyWith(UserNotFoundFailure value, $Res Function(UserNotFoundFailure) _then) = _$UserNotFoundFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$UserNotFoundFailureCopyWithImpl<$Res>
    implements $UserNotFoundFailureCopyWith<$Res> {
  _$UserNotFoundFailureCopyWithImpl(this._self, this._then);

  final UserNotFoundFailure _self;
  final $Res Function(UserNotFoundFailure) _then;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(UserNotFoundFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class NetworkFailure implements AuthFailure {
  const NetworkFailure({this.message = 'A network error occurred. Please try again.'});
  

@override@JsonKey() final  String message;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkFailureCopyWith<NetworkFailure> get copyWith => _$NetworkFailureCopyWithImpl<NetworkFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthFailure.network(message: $message)';
}


}

/// @nodoc
abstract mixin class $NetworkFailureCopyWith<$Res> implements $AuthFailureCopyWith<$Res> {
  factory $NetworkFailureCopyWith(NetworkFailure value, $Res Function(NetworkFailure) _then) = _$NetworkFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$NetworkFailureCopyWithImpl<$Res>
    implements $NetworkFailureCopyWith<$Res> {
  _$NetworkFailureCopyWithImpl(this._self, this._then);

  final NetworkFailure _self;
  final $Res Function(NetworkFailure) _then;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(NetworkFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SessionExpiredFailure implements AuthFailure {
  const SessionExpiredFailure({this.message = 'Your session has expired. Please sign in again.'});
  

@override@JsonKey() final  String message;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionExpiredFailureCopyWith<SessionExpiredFailure> get copyWith => _$SessionExpiredFailureCopyWithImpl<SessionExpiredFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionExpiredFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthFailure.sessionExpired(message: $message)';
}


}

/// @nodoc
abstract mixin class $SessionExpiredFailureCopyWith<$Res> implements $AuthFailureCopyWith<$Res> {
  factory $SessionExpiredFailureCopyWith(SessionExpiredFailure value, $Res Function(SessionExpiredFailure) _then) = _$SessionExpiredFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SessionExpiredFailureCopyWithImpl<$Res>
    implements $SessionExpiredFailureCopyWith<$Res> {
  _$SessionExpiredFailureCopyWithImpl(this._self, this._then);

  final SessionExpiredFailure _self;
  final $Res Function(SessionExpiredFailure) _then;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SessionExpiredFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class UnknownAuthFailure implements AuthFailure {
  const UnknownAuthFailure({this.message = 'An unexpected error occurred.'});
  

@override@JsonKey() final  String message;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnknownAuthFailureCopyWith<UnknownAuthFailure> get copyWith => _$UnknownAuthFailureCopyWithImpl<UnknownAuthFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownAuthFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthFailure.unknown(message: $message)';
}


}

/// @nodoc
abstract mixin class $UnknownAuthFailureCopyWith<$Res> implements $AuthFailureCopyWith<$Res> {
  factory $UnknownAuthFailureCopyWith(UnknownAuthFailure value, $Res Function(UnknownAuthFailure) _then) = _$UnknownAuthFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$UnknownAuthFailureCopyWithImpl<$Res>
    implements $UnknownAuthFailureCopyWith<$Res> {
  _$UnknownAuthFailureCopyWithImpl(this._self, this._then);

  final UnknownAuthFailure _self;
  final $Res Function(UnknownAuthFailure) _then;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(UnknownAuthFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
