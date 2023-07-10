import 'package:ecommerce_c8_online/domain/dataSource/auth_online_dataSource.dart';
import 'package:ecommerce_c8_online/domain/model/AuthResultDto.dart';
import 'package:ecommerce_c8_online/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository{
  AuthOnlineDataSource onlineDataSource;

  AuthRepositoryImpl(this.onlineDataSource);

  @override
  Future<AuthResultDto> login(String email, String password) {
    return onlineDataSource.login(email, password);
  }

  @override
  Future<AuthResultDto> register(String name, String email, String phone, String password, String repassword) {
    return onlineDataSource.register(name, email, phone, password, repassword);
  }
}