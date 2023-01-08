import 'package:flutter/material.dart';
import 'package:post_gram_ui/domain/exceptions.dart';

class ErrorPostGramWidget extends StatelessWidget {
  final Exception _errorMessage;
  const ErrorPostGramWidget(
    this._errorMessage, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(_errorMessage is PostGramException
          ? (_errorMessage as PostGramException).message.toString()
          : "Inner exeption"),
    );
  }
}
