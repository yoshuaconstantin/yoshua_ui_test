import 'login_response_data.dart';

class LoginResponse {
  final LoginResponseData data;
  final bool isSuccessful;

  LoginResponse({
    required this.data,
    required this.isSuccessful,

  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    data: json['data'] != null ? LoginResponseData.fromJson(json['data']) : LoginResponseData.fromJson({}),
    isSuccessful: json['isSuccessful'],

  );
}