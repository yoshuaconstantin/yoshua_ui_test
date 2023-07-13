class LoginResponseData {
  final String kodeUser;
  final String namaUser;
  final String npk;
  final String kodeKantor;
  final String email;
  final String token;

  LoginResponseData({
    required this.kodeUser,
    required this.namaUser,
    required this.npk,
    required this.kodeKantor,
    required this.email,
    required this.token
  });

  factory LoginResponseData.fromJson(Map<String, dynamic> json) => LoginResponseData(
      kodeUser: json['kodeUser'],
      namaUser: json['namaUser'],
      npk: json['npk'],
      kodeKantor: json['kodeKantor'],
      email: json['email'],
      token: json['token']
  );
}