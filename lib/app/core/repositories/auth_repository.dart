import 'package:injectable/injectable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:dishdash/app/core/models/user/user.dart';
import 'package:dishdash/app/core/services/storage/offline_client.dart';
import 'package:dishdash/app/core/services/storage/storage_keys.dart';
import 'package:dishdash/app/core/custom_printer.dart';

abstract class AuthRepository {
  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  });

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<bool> isUserLoggedIn();

  Future<User?> getCurrentUser();
}

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final OfflineClient _offlineClient;

  AuthRepositoryImpl(this._firebaseAuth, this._offlineClient);

  @override
  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      debug('Attempting sign up for: $email');

      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = credential.user;
      if (firebaseUser != null) {
        // Update display name in Firebase
        await firebaseUser.updateDisplayName(fullName);
        await firebaseUser.reload();

        // Create our user model
        final firstName = _extractFirstName(fullName);
        final user = User(
          uid: firebaseUser.uid,
          email: firebaseUser.email!,
          fullName: fullName,
          firstName: firstName,
          photoUrl: firebaseUser.photoURL,
          isEmailVerified: firebaseUser.emailVerified,
          createdAt: DateTime.now(),
        );

        // Store user data locally
        await _storeUserLocally(user);

        info('Sign up successful for: $email');
        return user;
      }

      error('Sign up failed for: $email - Firebase user is null');
      return null;
    } on firebase_auth.FirebaseAuthException catch (e) {
      error('Firebase Auth Exception - Code: ${e.code}, Message: ${e.message}');
      error('Sign up failed for: $email - ${e.message}');
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      error('Unexpected error in signUpWithEmailAndPassword: ${e.toString()}');
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      debug('Attempting sign in for: $email');

      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = credential.user;
      if (firebaseUser != null) {
        final firstName = _extractFirstName(firebaseUser.displayName ?? '');
        final user = User(
          uid: firebaseUser.uid,
          email: firebaseUser.email!,
          fullName: firebaseUser.displayName ?? '',
          firstName: firstName,
          photoUrl: firebaseUser.photoURL,
          isEmailVerified: firebaseUser.emailVerified,
          createdAt: DateTime.now(),
        );

        await _storeUserLocally(user);
        info('Sign in successful for: $email');
        return user;
      }

      error('Sign in failed for: $email - Firebase user is null');
      return null;
    } on firebase_auth.FirebaseAuthException catch (e) {
      error('Firebase Auth Exception - Code: ${e.code}, Message: ${e.message}');
      error('Sign in failed for: $email - ${e.message}');
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      error('Unexpected error in signInWithEmailAndPassword: ${e.toString()}');
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      debug('Attempting sign out');

      await _firebaseAuth.signOut();
      await _clearUserData();

      info('Sign out successful');
    } catch (e) {
      error('Sign out failed - Error: ${e.toString()}');
      throw Exception('Failed to sign out: ${e.toString()}');
    }
  }

  @override
Future<bool> isUserLoggedIn() async {
  final firebaseUser = _firebaseAuth.currentUser;
  final isStoredLoggedIn = await _offlineClient.getBool(StorageKeys.isLoggedIn);
  final isLoggedIn = firebaseUser != null && isStoredLoggedIn;

  debug(
    'User logged in status: $isLoggedIn (Firebase: ${firebaseUser != null}, Local: $isStoredLoggedIn)',
  );

  return isLoggedIn;
}

@override
Future<User?> getCurrentUser() async {
  final firebaseUser = _firebaseAuth.currentUser;
  if (firebaseUser != null) {
    final firstName = await _offlineClient.getString(StorageKeys.userFirstName);
    debug('Retrieved current user: ${firebaseUser.email}');
    return User(
      uid: firebaseUser.uid,
      email: firebaseUser.email!,
      fullName: firebaseUser.displayName ?? '',
      firstName: firstName,
      photoUrl: firebaseUser.photoURL,
      isEmailVerified: firebaseUser.emailVerified,
      createdAt: DateTime.now(),
    );
  }

  debug('No current user found');
  return null;
}

  // Private helper methods
  String _extractFirstName(String fullName) {
    if (fullName.trim().isEmpty) return '';
    return fullName.trim().split(' ').first;
  }

  Future<void> _storeUserLocally(User user) async {
    try {
      await _offlineClient.setString(StorageKeys.userFirstName, user.firstName);
      await _offlineClient.setString(StorageKeys.userEmail, user.email);
      await _offlineClient.setBool(StorageKeys.isLoggedIn, true);

      // Get and store the Firebase ID token
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser != null) {
        final token = await firebaseUser.getIdToken();
        await _offlineClient.setString(StorageKeys.userToken, token!);
      }

      debug('User data stored locally for: ${user.email}');
    } catch (e) {
      error('Error storing user data locally: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> _clearUserData() async {
    try {
      await _offlineClient.remove(StorageKeys.userFirstName);
      await _offlineClient.remove(StorageKeys.userEmail);
      await _offlineClient.remove(StorageKeys.userToken);
      await _offlineClient.setBool(StorageKeys.isLoggedIn, false);

      debug('User data cleared from local storage');
    } catch (e) {
      error('Error clearing user data: ${e.toString()}');
      rethrow;
    }
  }

  Exception _handleFirebaseAuthException(
    firebase_auth.FirebaseAuthException e,
  ) {
    switch (e.code) {
      case 'weak-password':
        return Exception('The password provided is too weak.');
      case 'email-already-in-use':
        return Exception('An account already exists for this email.');
      case 'invalid-email':
        return Exception('The email address is not valid.');
      case 'user-not-found':
        return Exception('No user found for this email.');
      case 'wrong-password':
        return Exception('Wrong password provided.');
      case 'user-disabled':
        return Exception('This user account has been disabled.');
      case 'too-many-requests':
        return Exception('Too many requests. Please try again later.');
      case 'operation-not-allowed':
        return Exception('Email/password accounts are not enabled.');
      default:
        return Exception('Authentication failed: ${e.message}');
    }
  }
}

// Register FirebaseAuth as a singleton
@module
abstract class FirebaseAuthModule {
  @lazySingleton
  firebase_auth.FirebaseAuth get firebaseAuth =>
      firebase_auth.FirebaseAuth.instance;
}
