import 'package:injectable/injectable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
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

  Future<User?> signInWithGoogle();

  Future<void> signOut();

  Future<void> sendPasswordResetEmail({required String email});

  Future<bool> isUserLoggedIn();

  Future<User?> getCurrentUser();

  // Removed: isUserRegistered method completely (security fix #1 & #2)
}

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final OfflineClient _offlineClient;

  AuthRepositoryImpl(
    this._firebaseAuth,
    this._googleSignIn,
    this._offlineClient,
  );

  @override
  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      debug('Attempting sign up for: $email');

      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(), // Consistent input sanitization (fix #7)
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
        email: email.trim(), // Consistent input sanitization (fix #7)
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
  Future<User?> signInWithGoogle() async {
    try {
      debug('Attempting Google sign in');

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled the sign-in
        debug('Google sign in cancelled by user');
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final firebase_auth.UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);

      final firebaseUser = userCredential.user;
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
        info('Google sign in successful for: ${firebaseUser.email}');
        return user;
      }

      error('Google sign in failed - Firebase user is null');
      return null;
    } on firebase_auth.FirebaseAuthException catch (e) {
      error(
        'Firebase Auth Exception during Google sign in - Code: ${e.code}, Message: ${e.message}',
      );
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      error('Unexpected error in signInWithGoogle: ${e.toString()}');
      throw Exception('Google sign in failed: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      debug('Attempting sign out');

      // Sign out from Firebase
      await _firebaseAuth.signOut();

      // Sign out from Google
      await _googleSignIn.signOut();

      // Clear user data (this will set isLoggedIn to false)
      await _clearUserData();

      info('Sign out successful');
    } catch (e) {
      error('Sign out failed - Error: ${e.toString()}');
      throw Exception('Failed to sign out: ${e.toString()}');
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      debug('Attempting to send password reset email to: $email');

      // Always attempt to send email - Firebase will handle non-existent users silently
      // This prevents user enumeration attacks (Security fix #1)
      await _firebaseAuth.sendPasswordResetEmail(
        email: email.trim(),
      ); // Consistent sanitization (fix #7)

      info('Password reset email request processed for: $email');
    } on firebase_auth.FirebaseAuthException catch (e) {
      error('Firebase Auth Exception - Code: ${e.code}, Message: ${e.message}');
      error('Failed to send password reset email to: $email - ${e.message}');
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      error('Unexpected error in sendPasswordResetEmail: ${e.toString()}');
      throw Exception('Failed to send password reset email: ${e.toString()}');
    }
  }

  @override
  Future<bool> isUserLoggedIn() async {
    try {
      // First check local storage - this is our source of truth
      final isStoredLoggedIn = await _offlineClient.getBool(
        StorageKeys.isLoggedIn,
      );

      debug('Local storage isLoggedIn: $isStoredLoggedIn');

      // If local storage says user is not logged in, return false immediately
      if (!isStoredLoggedIn) {
        debug('User not logged in according to local storage');
        return false;
      }

      // If local storage says user is logged in, verify with Firebase
      final firebaseUser = _firebaseAuth.currentUser;
      final isFirebaseLoggedIn = firebaseUser != null;

      debug('Firebase user exists: $isFirebaseLoggedIn');

      // Both conditions must be true for the user to be considered logged in
      final isLoggedIn = isStoredLoggedIn && isFirebaseLoggedIn;

      debug('Final logged in status: $isLoggedIn');

      // If there's a mismatch (local says true but Firebase says false),
      // clear the local data to maintain consistency
      if (isStoredLoggedIn && !isFirebaseLoggedIn) {
        debug('Mismatch detected - clearing local data');
        await _clearUserData();
        return false;
      }

      return isLoggedIn;
    } catch (e) {
      error('Error checking login status: ${e.toString()}');
      return false;
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      // First check if user is logged in according to our logic
      final isLoggedIn = await isUserLoggedIn();
      if (!isLoggedIn) {
        debug('User is not logged in');
        return null;
      }

      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser != null) {
        final firstName = await _offlineClient.getString(
          StorageKeys.userFirstName,
        );
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
    } catch (e) {
      error('Error getting current user: ${e.toString()}');
      return null;
    }
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
        return Exception(
          'Invalid email or password. Please check your credentials and try again.',
        );
      case 'wrong-password':
        return Exception(
          'Invalid email or password. Please check your credentials and try again.',
        );
      case 'user-disabled':
        return Exception('This user account has been disabled.');
      case 'too-many-requests':
        return Exception('Too many requests. Please try again later.');
      case 'operation-not-allowed':
        return Exception('Email/password accounts are not enabled.');
      case 'account-exists-with-different-credential':
        return Exception(
          'An account already exists with a different credential.',
        );
      case 'invalid-credential':
        return Exception(
          'Invalid email or password. Please check your credentials and try again.',
        );
      case 'network-request-failed':
        return Exception(
          'Network error. Please check your connection and try again.',
        );
      case 'requires-recent-login':
        return Exception(
          'This operation requires recent authentication. Please sign in again.',
        );
      case 'credential-already-in-use':
        return Exception(
          'This credential is already associated with a different user account.',
        );
      case 'invalid-verification-code':
        return Exception('The verification code is invalid. Please try again.');
      case 'invalid-verification-id':
        return Exception('The verification ID is invalid. Please try again.');
      case 'session-expired':
        return Exception('Your session has expired. Please sign in again.');
      default:
        return Exception('Authentication failed. Please try again.');
    }
  }
}

// Register FirebaseAuth and GoogleSignIn as singletons
@module
abstract class AuthModule {
  @lazySingleton
  firebase_auth.FirebaseAuth get firebaseAuth =>
      firebase_auth.FirebaseAuth.instance;

  @lazySingleton
  GoogleSignIn get googleSignIn => GoogleSignIn(
    // Optional: Add scopes if needed
    scopes: ['email', 'profile'],
  );
}
