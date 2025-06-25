extension StringExtensions on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(this);
  }

  bool get isStrongPassword {
    // At least 8 characters, contains at least one letter, one number, and one special character
    final passwordRegex = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );
    return passwordRegex.hasMatch(this);
  }

  bool get isValidName {
    // Allow letters, spaces, hyphens, apostrophes, and dots
    final nameRegExp = RegExp(r"^[a-zA-Z\s\-'.]{2,}$");
    return nameRegExp.hasMatch(trim());
  }

  String get toSentenceCase {
    if (isEmpty) return '';
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String get initials {
    if (isEmpty) return '';
    final words = trim().split(' ');
    if (words.length == 1) {
      return words[0][0].toUpperCase();
    }
    return '${words[0][0]}${words[1][0]}'.toUpperCase();
  }

  // Password strength checker
  String get passwordStrengthMessage {
    if (length < 8) {
      return 'Password must be at least 8 characters long';
    }

    bool hasLetter = RegExp(r'[A-Za-z]').hasMatch(this);
    bool hasNumber = RegExp(r'\d').hasMatch(this);
    bool hasSpecialChar = RegExp(r'[@$!%*?&]').hasMatch(this);

    if (!hasLetter) {
      return 'Password must contain at least one letter';
    }
    if (!hasNumber) {
      return 'Password must contain at least one number';
    }
    if (!hasSpecialChar) {
      return 'Password must contain at least one special character (@\$!%*?&)';
    }

    return 'Strong password';
  }

  bool get isPasswordStrong => isStrongPassword;
}
