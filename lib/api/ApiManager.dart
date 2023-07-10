import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_c8_online/api/interceptor/LoggingInterceptor.dart';
import 'package:ecommerce_c8_online/api/request/LoginRequest.dart';
import 'package:ecommerce_c8_online/api/response/LoginResponse.dart';
import 'package:ecommerce_c8_online/api/response/categories/CategoriesResponse.dart';
import 'package:ecommerce_c8_online/domain/customException/NetworkException.dart';
import 'package:ecommerce_c8_online/domain/customException/ServerErrorException.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:injectable/injectable.dart';

import 'request/RegisterRequest.dart';
import 'response/register/RegisterResponse.dart';

@singleton
class ApiManager{
  static const String baseUrl = "route-ecommerce.onrender.com";

  http.Client client = InterceptedClient.build(interceptors: [
    LoggingInterceptor(),
  ]);

  Future<RegisterResponse> register(String name,String email,String phone,String password,
      String rePassword)async{
    var uri =  Uri.https(baseUrl,"api/v1/auth/signup");
    var requestBody = RegisterRequest(
        name: name,email:email,
        password: password,
        rePassword: rePassword,
        phone: phone
    );
    try{
      var response = await client.post(uri,body: requestBody.toJson());
      var registerResponse =
      RegisterResponse.fromJson(jsonDecode(response.body));
      if(!registerResponse.isSuccess()){
        throw ServerErrorException(errorMessage: registerResponse.getErrorMessage(),
            httpResponseCode: response.statusCode);
      }
      return registerResponse;
    }on TimeoutException catch(e){
      throw NetworkException("Timout: please check internet connection");
    }on HttpException catch (e){
      throw NetworkException("Htto exception: "
          "couldn't reach server");
    }
  }

  Future<LoginResponse> login(String email,String password)async{
    var uri =  Uri.https(baseUrl,"api/v1/auth/signin");
    //api/v1/auth/signin
    try{
      var requestBody = LoginRequest(email:email, password: password);
      var response = await client.post(uri,body: requestBody.toJson());
      var loginResponse = LoginResponse.fromJson(jsonDecode(response.body));
      if(!loginResponse.isSuccess()){
        throw ServerErrorException(errorMessage: loginResponse.message,
            statusMsg: loginResponse.statusMsg,
            httpResponseCode: response.statusCode);
      }
      return loginResponse;
    }on TimeoutException catch(e){
      throw NetworkException("Timout: please check internet connection");
    }on HttpException catch (e){
      throw NetworkException("Htto exception: "
          "couldn't reach server");
    }
  }

  Future<CategoriesResponse> getCateogories({String? categorySlug,int limit = 20,int page = 1})async{
    var params = {
      'limit' : '$limit',
      'page' : '$page'
    };
    if(categorySlug!=null){
      params['keyword']  = categorySlug;
    }

    var uri =  Uri.https(baseUrl,"api/v1/categories", params);
    //api/v1/auth/signin
    try{
      var response = await client.get(uri);
      return CategoriesResponse.fromJson(jsonDecode(response.body));
    }on TimeoutException catch(e){
      throw NetworkException("Timout: please check internet connection");
    }on HttpException catch (e){
      throw NetworkException("Htto exception: "
          "couldn't reach server");
    }
  }
}