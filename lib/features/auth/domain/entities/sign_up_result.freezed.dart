// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignUpResult {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpResult);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpResult()';
}


}

/// @nodoc
class $SignUpResultCopyWith<$Res>  {
$SignUpResultCopyWith(SignUpResult _, $Res Function(SignUpResult) __);
}


/// Adds pattern-matching-related methods to [SignUpResult].
extension SignUpResultPatterns on SignUpResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SignUpConfirmed value)?  confirmed,TResult Function( EmailVerificationRequired value)?  emailVerificationRequired,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SignUpConfirmed() when confirmed != null:
return confirmed(_that);case EmailVerificationRequired() when emailVerificationRequired != null:
return emailVerificationRequired(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SignUpConfirmed value)  confirmed,required TResult Function( EmailVerificationRequired value)  emailVerificationRequired,}){
final _that = this;
switch (_that) {
case SignUpConfirmed():
return confirmed(_that);case EmailVerificationRequired():
return emailVerificationRequired(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SignUpConfirmed value)?  confirmed,TResult? Function( EmailVerificationRequired value)?  emailVerificationRequired,}){
final _that = this;
switch (_that) {
case SignUpConfirmed() when confirmed != null:
return confirmed(_that);case EmailVerificationRequired() when emailVerificationRequired != null:
return emailVerificationRequired(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( AuthUser user)?  confirmed,TResult Function( String email)?  emailVerificationRequired,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SignUpConfirmed() when confirmed != null:
return confirmed(_that.user);case EmailVerificationRequired() when emailVerificationRequired != null:
return emailVerificationRequired(_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( AuthUser user)  confirmed,required TResult Function( String email)  emailVerificationRequired,}) {final _that = this;
switch (_that) {
case SignUpConfirmed():
return confirmed(_that.user);case EmailVerificationRequired():
return emailVerificationRequired(_that.email);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( AuthUser user)?  confirmed,TResult? Function( String email)?  emailVerificationRequired,}) {final _that = this;
switch (_that) {
case SignUpConfirmed() when confirmed != null:
return confirmed(_that.user);case EmailVerificationRequired() when emailVerificationRequired != null:
return emailVerificationRequired(_that.email);case _:
  return null;

}
}

}

/// @nodoc


class SignUpConfirmed implements SignUpResult {
  const SignUpConfirmed(this.user);
  

 final  AuthUser user;

/// Create a copy of SignUpResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpConfirmedCopyWith<SignUpConfirmed> get copyWith => _$SignUpConfirmedCopyWithImpl<SignUpConfirmed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpConfirmed&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'SignUpResult.confirmed(user: $user)';
}


}

/// @nodoc
abstract mixin class $SignUpConfirmedCopyWith<$Res> implements $SignUpResultCopyWith<$Res> {
  factory $SignUpConfirmedCopyWith(SignUpConfirmed value, $Res Function(SignUpConfirmed) _then) = _$SignUpConfirmedCopyWithImpl;
@useResult
$Res call({
 AuthUser user
});


$AuthUserCopyWith<$Res> get user;

}
/// @nodoc
class _$SignUpConfirmedCopyWithImpl<$Res>
    implements $SignUpConfirmedCopyWith<$Res> {
  _$SignUpConfirmedCopyWithImpl(this._self, this._then);

  final SignUpConfirmed _self;
  final $Res Function(SignUpConfirmed) _then;

/// Create a copy of SignUpResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(SignUpConfirmed(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AuthUser,
  ));
}

/// Create a copy of SignUpResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthUserCopyWith<$Res> get user {
  
  return $AuthUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

/// @nodoc


class EmailVerificationRequired implements SignUpResult {
  const EmailVerificationRequired({required this.email});
  

 final  String email;

/// Create a copy of SignUpResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailVerificationRequiredCopyWith<EmailVerificationRequired> get copyWith => _$EmailVerificationRequiredCopyWithImpl<EmailVerificationRequired>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailVerificationRequired&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'SignUpResult.emailVerificationRequired(email: $email)';
}


}

/// @nodoc
abstract mixin class $EmailVerificationRequiredCopyWith<$Res> implements $SignUpResultCopyWith<$Res> {
  factory $EmailVerificationRequiredCopyWith(EmailVerificationRequired value, $Res Function(EmailVerificationRequired) _then) = _$EmailVerificationRequiredCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$EmailVerificationRequiredCopyWithImpl<$Res>
    implements $EmailVerificationRequiredCopyWith<$Res> {
  _$EmailVerificationRequiredCopyWithImpl(this._self, this._then);

  final EmailVerificationRequired _self;
  final $Res Function(EmailVerificationRequired) _then;

/// Create a copy of SignUpResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(EmailVerificationRequired(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
