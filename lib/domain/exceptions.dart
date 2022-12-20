class NotFoundPostGramException implements PostGramException {
  @override
  final String message;
  const NotFoundPostGramException([this.message = ""]);
}

class WrongCredentionalPostGramException implements PostGramException {
  @override
  final String message;
  const WrongCredentionalPostGramException([this.message = ""]);
}

class NoNetworkPostGramException implements PostGramException {
  @override
  final String message;
  const NoNetworkPostGramException([this.message = ""]);
}

class InternalServerPostGramException implements PostGramException {
  @override
  final String message;
  const InternalServerPostGramException([this.message = ""]);
}

class InnerPostGramException implements PostGramException {
  @override
  final String message;
  const InnerPostGramException([this.message = ""]);
}

class ValidationPostGramException implements PostGramException {
  dynamic data;
  @override
  String message;
  ValidationPostGramException(this.data, [this.message = ""]);
}

class PostGramException implements Exception {
  final String message;
  const PostGramException([this.message = ""]);
}
