import 'package:injectable/injectable.dart';
import 'package:dishdash/app/core/models/data.dart';
import 'package:dishdash/app/core/models/user/user.dart';
import 'package:dishdash/app/core/repositories/auth_repository.dart';

@lazySingleton
class AuthUseCase {
  final AuthRepository _repository;

  AuthUseCase(this._repository);

  Future<Data<User>> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final user = await _repository.signUpWithEmailAndPassword(
        email: email,
        password: password,
        fullName: fullName,
      );

      if (user != null) {
        return Data.success(data: user);
      }

      return const Data.error(message: 'Failed to create account');
    } catch (e) {
      return Data.error(message: e.toString());
    }
  }

  Future<Data<User>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _repository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (user != null) {
        return Data.success(data: user);
      }

      return const Data.error(message: 'Failed to sign in');
    } catch (e) {
      return Data.error(message: e.toString());
    }
  }

  Future<Data<User>> signInWithGoogle() async {
    try {
      final user = await _repository.signInWithGoogle();

      if (user != null) {
        return Data.success(data: user);
      }

      return const Data.error(message: 'Google sign in was cancelled');
    } catch (e) {
      return Data.error(message: e.toString());
    }
  }

  Future<Data<void>> signOut() async {
    try {
      await _repository.signOut();
      return const Data.success(data: null);
    } catch (e) {
      return Data.error(message: e.toString());
    }
  }

  Future<Data<void>> sendPasswordResetEmail({required String email}) async {
    try {
      await _repository.sendPasswordResetEmail(email: email);
      return const Data.success(data: null);
    } catch (e) {
      return Data.error(message: e.toString());
    }
  }

  // Removed: isUserRegistered method (security fix #1 & #2)

  Future<bool> isUserLoggedIn() async {
    try {
      return await _repository.isUserLoggedIn();
    } catch (e) {
      return false;
    }
  }

  Future<User?>? getCurrentUser() {
    try {
      return _repository.getCurrentUser();
    } catch (e) {
      return null;
    }
  }
}
