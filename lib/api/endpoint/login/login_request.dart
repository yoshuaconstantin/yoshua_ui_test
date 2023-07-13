class LoginRequest {
  final String username;
  final String password;
  final String chId = "SIHANDAL";
  final String hash = "";

  LoginRequest({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => <String, dynamic> {
    'username': this.username,
    'password': this.password,
    'chId': this.chId,
    'hash': this.hash,
  };
}