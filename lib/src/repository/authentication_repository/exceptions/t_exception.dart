class TExceptions implements Exception {
  ///The associated error message
  final String message;
  //{@macro log_in_with_email_and_password_failure}
  const TExceptions([this.message = 'An unknown exception occured.']);

  //create an authentication message from a firebase authentication exception code.
  factory TExceptions.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const TExceptions('Email already exists.');
      case 'invalid-email':
        return const TExceptions('Email is not valid or badly formatted.');
      case 'weak-password':
        return const TExceptions('Please enter a strong password.');
      case 'user-disabled':
        return const TExceptions(
            'This user has been diabled.please contact support for help.');
      case 'user-not-found':
        return const TExceptions('Invalid details. Please create a contact.');
      case 'wrong-password':
        return const TExceptions('Incorrect password. Please try again.');
      case 'too-many-requests':
        return const TExceptions(
            'Too many requests. Service temporarily blocked.');
      case 'invalid -argument':
        return const TExceptions(
            'An invalid argument was provided to an authentication method.');
      case 'invalid-password':
        return const TExceptions('Incorrect password. Please try again.');
      case 'invalid-phone-number':
        return const TExceptions('The provided Phone number is invalid.');
      case 'operation-not-allowed':
        return const TExceptions(
            'The provided sign-in provider is disabled for your Firebase project.');
      case 'session-cookie-expired':
        return const TExceptions(
            'The provide Firebase session cookie is expired.');
      case 'uid-alreday-exists':
        return const TExceptions(
            'The provide uid is already in use by an existing user.');
      default:
        return TExceptions();
    }
  }
}
