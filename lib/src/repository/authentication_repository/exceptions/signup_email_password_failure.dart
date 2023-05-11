class SignUpWithEmailPasswordFailure {
  final String message;

  const SignUpWithEmailPasswordFailure(
      [this.message = "An Unknown error occured."]);

  factory SignUpWithEmailPasswordFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return SignUpWithEmailPasswordFailure(
            'Please enter a stronger password.');

      case 'invalid-email':
        return SignUpWithEmailPasswordFailure(
            'Email is not valid or badly formatted.');

      case 'email-already-in-use':
        return SignUpWithEmailPasswordFailure(
            'An account already exists for that email.');

      case 'operation-not-allowed':
        return SignUpWithEmailPasswordFailure(
            'Operation is not allowed. Please contact support.');
      case 'invalid-password':
        return SignUpWithEmailPasswordFailure(
            'Username or password is incorrect. Please try again.');
      case 'wrong-password':
        return SignUpWithEmailPasswordFailure(
            'password is incorrect. Please try againnnn.');
      case 'user-not-found':
        return SignUpWithEmailPasswordFailure('User not found.');

      case 'user-disabled':
        return SignUpWithEmailPasswordFailure(
            'This user has been disabled. Please contact support for help.');

      default:
        return SignUpWithEmailPasswordFailure('');
    }
  }
}
