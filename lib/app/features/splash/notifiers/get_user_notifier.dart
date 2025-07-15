import 'package:dishdash/app/features/splash/notifiers/get_user_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:dishdash/app/core/usecases/auth_use_case.dart';

@lazySingleton
class GetUserNotifier extends StateNotifier<GetUserState> {
  final AuthUseCase _authUseCase;

  GetUserNotifier({
    required AuthUseCase authUseCase,
  }) : _authUseCase = authUseCase,
        super(const GetUserState.initial());

  Future<void> call() async {
    state = const GetUserState.loading();

    try {
      // Check if user is logged in
      final isLoggedIn = await _authUseCase.isUserLoggedIn();
      
      if (isLoggedIn) {
        // Get current user
        final user = await _authUseCase.getCurrentUser();
        
        if (user != null) {
          state = GetUserState.success(user);
        } else {
          state = const GetUserState.error();
        }
      } else {
        state = const GetUserState.error();
      }
    } catch (e) {
      state = const GetUserState.error();
    }
  }
}