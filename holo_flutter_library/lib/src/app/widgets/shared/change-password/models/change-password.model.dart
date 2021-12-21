class Logout {
  final String userId;
  final String accessToken;

  Logout({required this.userId, required this.accessToken});
  factory Logout.fromJson(Map<String, dynamic> json) {
    return Logout(
      userId: json['userId'],
      accessToken: json['accessToken'],
    );
  }
}
