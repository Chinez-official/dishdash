import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:dishdash/app/core/models/user/user.dart';
import 'package:dishdash/app/core/services/storage/offline_client.dart';
import 'package:dishdash/app/core/services/storage/storage_keys.dart';

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

  User? getCurrentUser();
}

class AuthRepositoryImpl implements AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final OfflineClient _offlineClient;

  AuthRepositoryImpl({
    required firebase_auth.FirebaseAuth firebaseAuth,
    required OfflineClient offlineClient,
  }) : _firebaseAuth = firebaseAuth,
       _offlineClient = offlineClient;

  @override
  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
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

        return user;
      }
      return null;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
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
        return user;
      }
      return null;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _clearUserData();
    } catch (e) {
      throw Exception('Failed to sign out: ${e.toString()}');
    }
  }

  @override
  Future<bool> isUserLoggedIn() async {
    final firebaseUser = _firebaseAuth.currentUser;
    final isStoredLoggedIn = _offlineClient.getBool(StorageKeys.isLoggedIn);
    return firebaseUser != null && isStoredLoggedIn;
  }

  @override
  User? getCurrentUser() {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      final firstName = _offlineClient.getString(StorageKeys.userFirstName);
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
    return null;
  }

  // Private helper methods
  String _extractFirstName(String fullName) {
    if (fullName.trim().isEmpty) return '';
    return fullName.trim().split(' ').first;
  }

  Future<void> _storeUserLocally(User user) async {
    await _offlineClient.setString(StorageKeys.userFirstName, user.firstName);
    await _offlineClient.setString(StorageKeys.userEmail, user.email);
    await _offlineClient.setBool(StorageKeys.isLoggedIn, true);

    // Get and store the Firebase ID token
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      final token = await firebaseUser.getIdToken();
      await _offlineClient.setString(StorageKeys.userToken, token);
    }
  }

  Future<void> _clearUserData() async {
    await _offlineClient.remove(StorageKeys.userFirstName);
    await _offlineClient.remove(StorageKeys.userEmail);
    await _offlineClient.remove(StorageKeys.userToken);
    await _offlineClient.setBool(StorageKeys.isLoggedIn, false);
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
