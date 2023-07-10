import 'package:ecommerce_c8_online/api/response/register/ServerErrorEntity.dart';
import 'package:ecommerce_c8_online/domain/model/AuthResultDto.dart';

import '../../User.dart';

class RegisterResponse {
  RegisterResponse({
      this.user, 
      this.token,});

  RegisterResponse.fromJson(dynamic json) {
    user = json['data'] != null ? User.fromJson(json['data']) : null;
    token = json['token'];
    error = json['errors'] != null ? ServerErrorEntity.fromJson(json["errors"]) :null;
  }
  User? user;
  String? token;
  String? message;
  String? statusMsg;
  ServerErrorEntity? error;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['token'] = token;
    return map;
  }
  bool isSuccess (){
    return statusMsg!='fail' && error== null;
  }
  String getErrorMessage(){
    return (message ?? error?.msg) ?? "";
  }
  AuthResultDto toAuthResultDto(){
    return AuthResultDto(
      user: user?.toUserDto(),
      token: token
    );
  }
}