import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class RedisterViewModel extends Cubit<RegisterviewState>{
  var _fullNameController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();
  @factoryMethod
  RedisterViewModel():super(Initstate());

  void creatAccount() {}
}
sealed class RegisterviewState{}
class Initstate extends RegisterviewState{}