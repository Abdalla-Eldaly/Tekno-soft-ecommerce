import 'package:ecommerce_c8_online/di/di.dart';
import 'package:ecommerce_c8_online/provider/auth_provider.dart';
import 'package:ecommerce_c8_online/ui/home/home_screen.dart';
import 'package:ecommerce_c8_online/ui/login/login_viewModel.dart';
import 'package:ecommerce_c8_online/ui/register/register_screen.dart';
import 'package:ecommerce_c8_online/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/validation_utils.dart';
import '../components/custom_form_field.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login';
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController(text: 'nabil@route.com');
  var passwordController = TextEditingController(text: '123456');

  LoginViewModel loginViewModel = getIt<LoginViewModel>(); // field injection

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginViewModel, LoginViewState>(
      bloc: loginViewModel,
      builder: (context, state) {
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 80,
                ),
                Image.asset('assets/images/route_logo_big.png'),
                Text(
                  'Welcome Back To Route',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(
                  'Please sign in with your mail',
                  style: Theme.of(context).textTheme?.labelSmall,
                ),
                SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomFormField(
                          controller: emailController,
                          label: 'Email Address',
                          hint: 'please enter Email Address',
                          keyboardType: TextInputType.emailAddress,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'please enter email';
                            }
                            if (!ValidationUtils.isValidEmail(text)) {
                              return 'please enter a valid email';
                            }
                          },
                        ),
                        CustomFormField(
                          controller: passwordController,
                          label: 'Password',
                          hint: 'please enter password',
                          keyboardType: TextInputType.text,
                          isPassword: true,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'please enter password';
                            }
                            if (text.length < 6) {
                              return 'password should at least 6 chars';
                            }
                          },
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              backgroundColor: Theme.of(context).primaryColor,
                              padding: EdgeInsets.symmetric(vertical: 12)),
                          onPressed: () {
                            login();
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        TextButton(onPressed: (){
                          Navigator.pushReplacementNamed(context,
                              RegisterScreen.routeName);
                        },child: Text('Don’t have an account? Create Account',
                          style: Theme.of(context).textTheme.labelMedium,),)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      listenWhen: (previous, current) {
        if(previous is LoadingState){
          DialogUtils.hideDialoge(context);
        }
        if(current is SuccessState ||
            current is LoadingState || current is FailState){
          return true;
        }
        return false;
      },
      buildWhen: (previous, current) {
        if(current is InitialState)return true;
        return false;
      },
      listener: (context, state) {
        // event
        if(state is FailState){
          // show message
          DialogUtils.showMessage(context,
              state.message?? state.exception?.toString() ??"Something Went Wrong",
              posActionName: "ok"
          );
        }else if(state is LoadingState){
          //show loading...
          DialogUtils.showLoading(context, state.loadingMessage??"Loading...");
        }else if(state is SuccessState){
          // show dialog
          // navigate to home screen
          DialogUtils.showMessage(context, "Logged In Successfully",
              posActionName: "ok",
              posAction: (){
                // save user data // runtime
                UserProvider userProvider = BlocProvider.of<UserProvider>(context,
                    listen: false);
                userProvider.login(LoggedInState(state.response.user,
                    state.response.token));
                Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
              });
        }
      },

    );
  }

  void login() async {
    // async - await
    if (formKey.currentState?.validate() == false) {
      return;
    }
    loginViewModel.login(emailController.text, passwordController.text);
  }
}
