import 'package:ecommerce_c8_online/domain/customException/NetworkException.dart';
import 'package:ecommerce_c8_online/domain/customException/ServerErrorException.dart';
import 'package:ecommerce_c8_online/domain/model/AuthResultDto.dart';
import 'package:ecommerce_c8_online/domain/usecase/register_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterViewModel extends Cubit<RegisterViewState> {
  RegisterUseCase registerUseCase;

  RegisterViewModel(this.registerUseCase) : super(InitialState());

  // Dependancy injection

  void register(String name, String email, String password, String rePassword,
      String phone) async {
    emit(LoadingState(loadingMessage: 'Loading...'));
    try{
      var response = await registerUseCase.invoke(name, email, phone, password, rePassword);
      emit(SuccessState(response));
    }on ServerErrorException catch(ex){
      emit(FailState(message: ex.errorMessage,exception: ex));
    }on NetworkException catch (ex) {
      emit(FailState(message: "please check your internet connection",exception: ex));
    }
  }
}
abstract class RegisterViewState{}
class InitialState extends RegisterViewState{}
class LoadingState extends RegisterViewState{
  String? loadingMessage;
  LoadingState({this.loadingMessage});
}
class SuccessState extends RegisterViewState{
  AuthResultDto response;
  SuccessState(this.response);
}
class FailState extends RegisterViewState{
  String? message;
  Exception? exception;
  FailState({this.message,this.exception});
}