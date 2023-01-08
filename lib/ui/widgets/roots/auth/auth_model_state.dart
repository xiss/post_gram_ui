class AuthModelState {
  final String? login;
  final String? password;
  final bool isLoading;
  final String? errorText;
  final String? errorLogin;
  final String? errorPassword;

  const AuthModelState({
    this.login,
    this.password,
    this.isLoading = false,
    this.errorText,
    this.errorLogin,
    this.errorPassword,
  });

  AuthModelState copyWith({
    String? login,
    String? password,
    bool? isLoading = false,
    String? errorText,
    String? errorLogin,
    String? errorPassword,
  }) {
    return AuthModelState(
      login: login ?? this.login,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorText: errorText,
      errorLogin: errorLogin,
      errorPassword: errorPassword,
    );
  }
}
