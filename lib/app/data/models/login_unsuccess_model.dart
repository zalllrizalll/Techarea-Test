class LoginUnsuccess {
  String? error;

  LoginUnsuccess({
    this.error,
  });

  LoginUnsuccess.fromJson(Map<String, dynamic> json) {
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['error'] = error;
    return data;
  }
}
