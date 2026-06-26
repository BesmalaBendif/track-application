class LoginUser {
  final int id;
  final String username;
  final String email;
  final String role;

  LoginUser({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
  });

  factory LoginUser.fromJson(Map<String, dynamic> json) {
    return LoginUser(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      role: json["role"],
    );
  }
}

class LoginResponse {
  final String accessToken;
  final String tokenType;
  final LoginUser user;

  LoginResponse({
    required this.accessToken,
    required this.tokenType,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json["access_token"],
      tokenType: json["token_type"],
      user: LoginUser.fromJson(json["user"]),
    );
  }
}