// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignInState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignInState()';
}


}

/// @nodoc
class $SignInStateCopyWith<$Res>  {
$SignInStateCopyWith(SignInState _, $Res Function(SignInState) __);
}


/// Adds pattern-matching-related methods to [SignInState].
extension SignInStatePatterns on SignInState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Success value)?  success,TResult Function( _Error value)?  error,TResult Function( _GoogleLoading value)?  googleLoading,TResult Function( _GoogleSuccess value)?  googleSuccess,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
return error(_that);case _GoogleLoading() when googleLoading != null:
return googleLoading(_that);case _GoogleSuccess() when googleSuccess != null:
return googleSuccess(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Success value)  success,required TResult Function( _Error value)  error,required TResult Function( _GoogleLoading value)  googleLoading,required TResult Function( _GoogleSuccess value)  googleSuccess,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Success():
return success(_that);case _Error():
return error(_that);case _GoogleLoading():
return googleLoading(_that);case _GoogleSuccess():
return googleSuccess(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Success value)?  success,TResult? Function( _Error value)?  error,TResult? Function( _GoogleLoading value)?  googleLoading,TResult? Function( _GoogleSuccess value)?  googleSuccess,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
return error(_that);case _GoogleLoading() when googleLoading != null:
return googleLoading(_that);case _GoogleSuccess() when googleSuccess != null:
return googleSuccess(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String firstName)?  success,TResult Function( String message)?  error,TResult Function()?  googleLoading,TResult Function( String firstName)?  googleSuccess,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.firstName);case _Error() when error != null:
return error(_that.message);case _GoogleLoading() when googleLoading != null:
return googleLoading();case _GoogleSuccess() when googleSuccess != null:
return googleSuccess(_that.firstName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String firstName)  success,required TResult Function( String message)  error,required TResult Function()  googleLoading,required TResult Function( String firstName)  googleSuccess,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Success():
return success(_that.firstName);case _Error():
return error(_that.message);case _GoogleLoading():
return googleLoading();case _GoogleSuccess():
return googleSuccess(_that.firstName);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String firstName)?  success,TResult? Function( String message)?  error,TResult? Function()?  googleLoading,TResult? Function( String firstName)?  googleSuccess,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.firstName);case _Error() when error != null:
return error(_that.message);case _GoogleLoading() when googleLoading != null:
return googleLoading();case _GoogleSuccess() when googleSuccess != null:
return googleSuccess(_that.firstName);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements SignInState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignInState.initial()';
}


}




/// @nodoc


class _Loading implements SignInState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignInState.loading()';
}


}




/// @nodoc


class _Success implements SignInState {
  const _Success(this.firstName);
  

 final  String firstName;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.firstName, firstName) || other.firstName == firstName));
}


@override
int get hashCode => Object.hash(runtimeType,firstName);

@override
String toString() {
  return 'SignInState.success(firstName: $firstName)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $SignInStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 String firstName
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? firstName = null,}) {
  return _then(_Success(
null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Error implements SignInState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SignInState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $SignInStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _GoogleLoading implements SignInState {
  const _GoogleLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoogleLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignInState.googleLoading()';
}


}




/// @nodoc


class _GoogleSuccess implements SignInState {
  const _GoogleSuccess(this.firstName);
  

 final  String firstName;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoogleSuccessCopyWith<_GoogleSuccess> get copyWith => __$GoogleSuccessCopyWithImpl<_GoogleSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoogleSuccess&&(identical(other.firstName, firstName) || other.firstName == firstName));
}


@override
int get hashCode => Object.hash(runtimeType,firstName);

@override
String toString() {
  return 'SignInState.googleSuccess(firstName: $firstName)';
}


}

/// @nodoc
abstract mixin class _$GoogleSuccessCopyWith<$Res> implements $SignInStateCopyWith<$Res> {
  factory _$GoogleSuccessCopyWith(_GoogleSuccess value, $Res Function(_GoogleSuccess) _then) = __$GoogleSuccessCopyWithImpl;
@useResult
$Res call({
 String firstName
});




}
/// @nodoc
class __$GoogleSuccessCopyWithImpl<$Res>
    implements _$GoogleSuccessCopyWith<$Res> {
  __$GoogleSuccessCopyWithImpl(this._self, this._then);

  final _GoogleSuccess _self;
  final $Res Function(_GoogleSuccess) _then;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? firstName = null,}) {
  return _then(_GoogleSuccess(
null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
