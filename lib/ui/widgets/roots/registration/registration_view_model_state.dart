class RegistrationViewModelState {
  final String? password;
  final String? passwordRetry;
  final DateTime? birthDate = DateTime.now();
  final String? email;
  final bool? isPrivate;
  final String? nickname;
  final String? patronymic;
  final String? surname;
  final String? name;

  final bool isLoading;
  final String? errorText;
  final String? errorEmail;
  final String? errorPassword;

  RegistrationViewModelState({
    //this.birthDate,
    this.name,
    this.isPrivate,
    this.patronymic,
    this.surname,
    this.nickname,
    this.email,
    this.passwordRetry,
    this.password,
    this.isLoading = false,
    this.errorText,
    this.errorEmail,
    this.errorPassword,
  });

  RegistrationViewModelState copyWith({
    String? password,
    String? passwordRetry,
    DateTime? birthDate,
    String? email,
    bool? isPrivate,
    String? nickname,
    String? patronymic,
    String? surname,
    String? name,
    bool? isLoading,
    String? errorText,
    String? errorEmail,
    String? errorPassword,
  }) {
    return RegistrationViewModelState(
      password: password ?? this.password,
      passwordRetry: passwordRetry ?? this.passwordRetry,
      //birthDate: birthDate ?? this.birthDate,
      email: email ?? this.email,
      isPrivate: isPrivate ?? this.isPrivate,
      nickname: nickname ?? this.nickname,
      patronymic: patronymic ?? this.patronymic,
      surname: surname ?? this.surname,
      name: name ?? this.name,
      isLoading: isLoading ?? this.isLoading,
      errorText: errorText ?? this.errorText,
      errorEmail: errorEmail ?? this.errorEmail,
      errorPassword: errorPassword ?? this.errorPassword,
    );
  }
}
