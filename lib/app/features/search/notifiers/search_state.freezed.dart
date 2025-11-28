// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchState()';
}


}

/// @nodoc
class $SearchStateCopyWith<$Res>  {
$SearchStateCopyWith(SearchState _, $Res Function(SearchState) __);
}


/// Adds pattern-matching-related methods to [SearchState].
extension SearchStatePatterns on SearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Success value)?  success,TResult Function( _Error value)?  error,TResult Function( _RecentSearchesLoaded value)?  recentSearchesLoaded,TResult Function( _LastSearchLoaded value)?  lastSearchLoaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
return error(_that);case _RecentSearchesLoaded() when recentSearchesLoaded != null:
return recentSearchesLoaded(_that);case _LastSearchLoaded() when lastSearchLoaded != null:
return lastSearchLoaded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Success value)  success,required TResult Function( _Error value)  error,required TResult Function( _RecentSearchesLoaded value)  recentSearchesLoaded,required TResult Function( _LastSearchLoaded value)  lastSearchLoaded,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Success():
return success(_that);case _Error():
return error(_that);case _RecentSearchesLoaded():
return recentSearchesLoaded(_that);case _LastSearchLoaded():
return lastSearchLoaded(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Success value)?  success,TResult? Function( _Error value)?  error,TResult? Function( _RecentSearchesLoaded value)?  recentSearchesLoaded,TResult? Function( _LastSearchLoaded value)?  lastSearchLoaded,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
return error(_that);case _RecentSearchesLoaded() when recentSearchesLoaded != null:
return recentSearchesLoaded(_that);case _LastSearchLoaded() when lastSearchLoaded != null:
return lastSearchLoaded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Meal> results,  String query,  List<String> recentSearches)?  success,TResult Function( String message,  List<String> recentSearches)?  error,TResult Function( List<String> recentSearches)?  recentSearchesLoaded,TResult Function( List<Meal> results,  String query)?  lastSearchLoaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.results,_that.query,_that.recentSearches);case _Error() when error != null:
return error(_that.message,_that.recentSearches);case _RecentSearchesLoaded() when recentSearchesLoaded != null:
return recentSearchesLoaded(_that.recentSearches);case _LastSearchLoaded() when lastSearchLoaded != null:
return lastSearchLoaded(_that.results,_that.query);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Meal> results,  String query,  List<String> recentSearches)  success,required TResult Function( String message,  List<String> recentSearches)  error,required TResult Function( List<String> recentSearches)  recentSearchesLoaded,required TResult Function( List<Meal> results,  String query)  lastSearchLoaded,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Success():
return success(_that.results,_that.query,_that.recentSearches);case _Error():
return error(_that.message,_that.recentSearches);case _RecentSearchesLoaded():
return recentSearchesLoaded(_that.recentSearches);case _LastSearchLoaded():
return lastSearchLoaded(_that.results,_that.query);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Meal> results,  String query,  List<String> recentSearches)?  success,TResult? Function( String message,  List<String> recentSearches)?  error,TResult? Function( List<String> recentSearches)?  recentSearchesLoaded,TResult? Function( List<Meal> results,  String query)?  lastSearchLoaded,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.results,_that.query,_that.recentSearches);case _Error() when error != null:
return error(_that.message,_that.recentSearches);case _RecentSearchesLoaded() when recentSearchesLoaded != null:
return recentSearchesLoaded(_that.recentSearches);case _LastSearchLoaded() when lastSearchLoaded != null:
return lastSearchLoaded(_that.results,_that.query);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements SearchState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchState.initial()';
}


}




/// @nodoc


class _Loading implements SearchState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchState.loading()';
}


}




/// @nodoc


class _Success implements SearchState {
  const _Success(final  List<Meal> results, this.query, final  List<String> recentSearches): _results = results,_recentSearches = recentSearches;
  

 final  List<Meal> _results;
 List<Meal> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

 final  String query;
 final  List<String> _recentSearches;
 List<String> get recentSearches {
  if (_recentSearches is EqualUnmodifiableListView) return _recentSearches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentSearches);
}


/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other._recentSearches, _recentSearches));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_results),query,const DeepCollectionEquality().hash(_recentSearches));

@override
String toString() {
  return 'SearchState.success(results: $results, query: $query, recentSearches: $recentSearches)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 List<Meal> results, String query, List<String> recentSearches
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? results = null,Object? query = null,Object? recentSearches = null,}) {
  return _then(_Success(
null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<Meal>,null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,null == recentSearches ? _self._recentSearches : recentSearches // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class _Error implements SearchState {
  const _Error(this.message, final  List<String> recentSearches): _recentSearches = recentSearches;
  

 final  String message;
 final  List<String> _recentSearches;
 List<String> get recentSearches {
  if (_recentSearches is EqualUnmodifiableListView) return _recentSearches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentSearches);
}


/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._recentSearches, _recentSearches));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(_recentSearches));

@override
String toString() {
  return 'SearchState.error(message: $message, recentSearches: $recentSearches)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message, List<String> recentSearches
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? recentSearches = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,null == recentSearches ? _self._recentSearches : recentSearches // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class _RecentSearchesLoaded implements SearchState {
  const _RecentSearchesLoaded(final  List<String> recentSearches): _recentSearches = recentSearches;
  

 final  List<String> _recentSearches;
 List<String> get recentSearches {
  if (_recentSearches is EqualUnmodifiableListView) return _recentSearches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentSearches);
}


/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecentSearchesLoadedCopyWith<_RecentSearchesLoaded> get copyWith => __$RecentSearchesLoadedCopyWithImpl<_RecentSearchesLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecentSearchesLoaded&&const DeepCollectionEquality().equals(other._recentSearches, _recentSearches));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_recentSearches));

@override
String toString() {
  return 'SearchState.recentSearchesLoaded(recentSearches: $recentSearches)';
}


}

/// @nodoc
abstract mixin class _$RecentSearchesLoadedCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory _$RecentSearchesLoadedCopyWith(_RecentSearchesLoaded value, $Res Function(_RecentSearchesLoaded) _then) = __$RecentSearchesLoadedCopyWithImpl;
@useResult
$Res call({
 List<String> recentSearches
});




}
/// @nodoc
class __$RecentSearchesLoadedCopyWithImpl<$Res>
    implements _$RecentSearchesLoadedCopyWith<$Res> {
  __$RecentSearchesLoadedCopyWithImpl(this._self, this._then);

  final _RecentSearchesLoaded _self;
  final $Res Function(_RecentSearchesLoaded) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? recentSearches = null,}) {
  return _then(_RecentSearchesLoaded(
null == recentSearches ? _self._recentSearches : recentSearches // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class _LastSearchLoaded implements SearchState {
  const _LastSearchLoaded(final  List<Meal> results, this.query): _results = results;
  

 final  List<Meal> _results;
 List<Meal> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

 final  String query;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LastSearchLoadedCopyWith<_LastSearchLoaded> get copyWith => __$LastSearchLoadedCopyWithImpl<_LastSearchLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LastSearchLoaded&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_results),query);

@override
String toString() {
  return 'SearchState.lastSearchLoaded(results: $results, query: $query)';
}


}

/// @nodoc
abstract mixin class _$LastSearchLoadedCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory _$LastSearchLoadedCopyWith(_LastSearchLoaded value, $Res Function(_LastSearchLoaded) _then) = __$LastSearchLoadedCopyWithImpl;
@useResult
$Res call({
 List<Meal> results, String query
});




}
/// @nodoc
class __$LastSearchLoadedCopyWithImpl<$Res>
    implements _$LastSearchLoadedCopyWith<$Res> {
  __$LastSearchLoadedCopyWithImpl(this._self, this._then);

  final _LastSearchLoaded _self;
  final $Res Function(_LastSearchLoaded) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? results = null,Object? query = null,}) {
  return _then(_LastSearchLoaded(
null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<Meal>,null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
