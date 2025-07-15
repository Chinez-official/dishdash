import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dishdash/app/core/models/user/user.dart';

part 'get_user_state.freezed.dart';

@freezed
class GetUserState with _$GetUserState {
  const factory GetUserState.initial() = _Initial;
  const factory GetUserState.loading() = _Loading;
  const factory GetUserState.success(User user) = _Success;
  const factory GetUserState.error() = _Error;
}