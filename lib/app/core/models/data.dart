import 'package:freezed_annotation/freezed_annotation.dart';

part 'data.freezed.dart';

@freezed
class Data<T> with _$Data<T> {
  const factory Data.success({required T data}) = _Success<T>;
  const factory Data.error({String? message}) = _Error<T>;
}
