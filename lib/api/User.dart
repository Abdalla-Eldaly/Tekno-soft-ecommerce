import 'package:ecommerce_c8_online/domain/model/UserDto.dart';

class User {
  User({
      this.name, 
      this.email, 
      this.phone, 
      this.id,});

  User.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    id = json['_id'];
  }
  String? name;
  String? email;
  String? phone;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['_id'] = id;
    return map;
  }

  UserDto toUserDto(){
    return UserDto(
      name: name,
      email: email,
      phone: phone,
      id: id
    );
  }
}