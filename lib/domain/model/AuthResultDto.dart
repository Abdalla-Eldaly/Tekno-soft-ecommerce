import 'package:ecommerce_c8_online/domain/model/UserDto.dart';

class AuthResultDto{
  UserDto? user;
  String? token;
  AuthResultDto({this.user,this.token});
}