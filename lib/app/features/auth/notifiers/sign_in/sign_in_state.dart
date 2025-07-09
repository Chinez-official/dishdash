import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_state.freezed.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState.initial() = _Initial;
  const factory SignInState.loading() = _Loading;
  const factory SignInState.success(String firstName) = _Success;
  const factory SignInState.error(String message) = _Error;
  const factory SignInState.googleLoading() = _GoogleLoading;
  const factory SignInState.googleSuccess(String firstName) = _GoogleSuccess;
}
