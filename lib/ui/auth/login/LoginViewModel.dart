import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginViewModel extends Cubit<LoginViewState> {
  @factoryMethod
  LoginViewModel() : super(InitialState());

  void loginPress() {
    // Implement the login logic here
  }
}

// Consider using a more descriptive name for the initial state
sealed class LoginViewState {}

class InitialState extends LoginViewState {}
