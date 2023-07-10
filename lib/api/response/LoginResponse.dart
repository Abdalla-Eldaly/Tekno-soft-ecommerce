
import 'package:ecommerce_c8_online/api/User.dart';
import 'package:ecommerce_c8_online/domain/model/AuthResultDto.dart';

/// message : "success"
/// user : {"name":"Mohamed Nabil","email":"nabil_c8_sun_1@route.com","role":"user"}
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0OTM0YTYyMmRmNmVjZDg3NWFhNjBkMSIsIm5hbWUiOiJNb2hhbWVkIE5hYmlsIiwicm9sZSI6InVzZXIiLCJpYXQiOjE2ODg0MDkzNTUsImV4cCI6MTY5NjE4NTM1NX0.v2ICKwsHDBOaBYDSxHwwLdiW5pw8udpk_Lm8LOXYvH0"

class LoginResponse {
  LoginResponse({
      this.message, 
      this.user, 
      this.token,});

  LoginResponse.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
    statusMsg = json['statusMsg'];
  }
  String? message;
  User? user;
  String? token;
  String? statusMsg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['token'] = token;
    return map;
  }

  bool isSuccess(){
    return statusMsg!='fail';
  }

  AuthResultDto toAuthResultDto(){
    return AuthResultDto(
      user:user?.toUserDto() ,
      token: token
    );
  }
}