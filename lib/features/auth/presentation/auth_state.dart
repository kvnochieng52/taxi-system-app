class AuthState {
  final String? accessToken;
  final bool isLoading;
  final String? errorMessage;

  AuthState({this.accessToken, this.isLoading = false, this.errorMessage});

  factory AuthState.initial() {
    return AuthState(); // Default state
  }

  factory AuthState.loading() {
    return AuthState(isLoading: true); // Loading state
  }

  factory AuthState.error(String message) {
    return AuthState(errorMessage: message); // Error state
  }
}
