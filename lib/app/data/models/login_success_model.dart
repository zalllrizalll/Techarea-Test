class LoginSuccess {
  String? token;

  LoginSuccess({this.token});

  LoginSuccess.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}
