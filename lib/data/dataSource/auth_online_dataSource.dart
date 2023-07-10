import 'package:ecommerce_c8_online/api/ApiManager.dart';
import 'package:ecommerce_c8_online/domain/dataSource/auth_online_dataSource.dart';
import 'package:ecommerce_c8_online/domain/model/AuthResultDto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthOnlineDataSource)
class AuthOnlineDataSourceImpl implements AuthOnlineDataSource{
  // extend -- implement
  //  classes -- interfaces
  ApiManager apiManager;

  AuthOnlineDataSourceImpl(this.apiManager);// depenedancy

  @override
  Future<AuthResultDto> login(String email, String password) async{
    var response  = await apiManager.login(email, password);
    return response.toAuthResultDto();
  }

  @override
  Future<AuthResultDto> register(String name, String email, String phone, String password, String rePassword)async {
    var response = await apiManager.register(name, email, phone, password, rePassword);
    return response.toAuthResultDto();
  }
}