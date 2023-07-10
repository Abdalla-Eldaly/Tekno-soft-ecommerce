import 'package:ecommerce_c8_online/domain/customException/NetworkException.dart';
import 'package:ecommerce_c8_online/domain/customException/ServerErrorException.dart';
import 'package:ecommerce_c8_online/domain/model/AuthResultDto.dart';
import 'package:ecommerce_c8_online/domain/usecase/login_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginViewModel extends Cubit<LoginViewState>{

  LoginUseCase loginUseCase;

  LoginViewModel(this.loginUseCase) : super(InitialState());

  void login(String email, String password) async {
    emit(LoadingState(loadingMessage: 'Loading...'));
    try {
      var response = await loginUseCase.invoke(email, password);
      emit(SuccessState(response));
    } on ServerErrorException catch (ex) {
      emit(FailState(message: ex.errorMessage, exception: ex));
    } on NetworkException catch (ex) {
      emit(FailState(
          message: "please check your internet connection", exception: ex));
    }
  }
}
abstract class LoginViewState{}
class InitialState extends LoginViewState{}
class LoadingState extends LoginViewState{
  String? loadingMessage;
  LoadingState({this.loadingMessage});
}
class SuccessState extends LoginViewState{
  AuthResultDto response;
  SuccessState(this.response);
}
class FailState extends LoginViewState{
  String? message;
  Exception? exception;
  FailState({this.message,this.exception});
}