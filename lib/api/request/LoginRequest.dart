/// email : "nabil_c8_sun_1@route.com"
/// password : "12356"

class LoginRequest {
  LoginRequest({
      this.email, 
      this.password,});

  LoginRequest.fromJson(dynamic json) {
    email = json['email'];
    password = json['password'];
  }
  String? email;
  String? password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    return map;
  }

}