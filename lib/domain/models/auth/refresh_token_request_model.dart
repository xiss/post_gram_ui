import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_request_model.g.dart';

@JsonSerializable()
class RefreshTokenRequestModel {
  final String refreshToken;

  RefreshTokenRequestModel({
    required this.refreshToken,
  });

  factory RefreshTokenRequestModel.fromJson(Map<String, dynamic> json) {
    return _$RefreshTokenRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RefreshTokenRequestModelToJson(this);
  }
}
