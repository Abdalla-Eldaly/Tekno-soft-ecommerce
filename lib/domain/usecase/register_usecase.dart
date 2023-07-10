import 'package:ecommerce_c8_online/api/response/register/RegisterResponse.dart';
import 'package:ecommerce_c8_online/domain/model/AuthResultDto.dart';
import 'package:ecommerce_c8_online/domain/repository/auth_repository.dart';

class RegisterUseCase {
  AuthRepository repository;
  RegisterUseCase(this.repository);

  Future<AuthResultDto> invoke(String name,String email,String phone,
      String password,String rePassword)async{
    return repository.register(name, email, phone, password, rePassword);
  }
}