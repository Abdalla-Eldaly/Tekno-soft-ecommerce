import 'package:ecommerce_c8_online/di/di.dart';
import 'package:ecommerce_c8_online/provider/auth_provider.dart';
import 'package:ecommerce_c8_online/ui/home/home_screen.dart';
import 'package:ecommerce_c8_online/ui/login/login_screen.dart';
import 'package:ecommerce_c8_online/ui/register/register_viewModel.dart';
import 'package:ecommerce_c8_online/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/validation_utils.dart';
import '../components/custom_form_field.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'Register';
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController(text: 'Mohamed nabil');

  var emailController =
      TextEditingController(text: 'nabil_c8_online_1@route.com');

  var mobileController = TextEditingController(text: '01117576576');

  var passwordController = TextEditingController(text: '123456');

  var passwordConfirmationController = TextEditingController(text: '123456');

  RegisterViewModel viewModel = getIt<RegisterViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterViewModel, RegisterViewState>(
      bloc: viewModel,
      listenWhen: (previous, current) {
        if (previous is LoadingState) {
          DialogUtils.hideDialoge(context);
        }
        if (current is SuccessState ||
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
          DialogUtils.showMessage(context, "User Registered Successfully",
              posActionName: "ok",
              posAction: (){
                // save user data // runtime
                UserProvider userProvider = BlocProvider.of<UserProvider>(context,
                    listen: false);
                userProvider.login(LoggedInState(state.response.user!,
                    state.response.token!));
                Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
              });
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 80,),
                  Image.asset('assets/images/route_logo_big.png'),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomFormField(
                          controller: nameController,
                          label: 'Full Name',
                          hint: 'please enter Full Name',
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'please enter full name';
                            }
                          },
                        ),
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
                          controller: mobileController,
                          label: 'Mobile No.',
                          hint: 'please enter your Mobile Number',
                          keyboardType: TextInputType.phone,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'please enter your Mobile Num';
                            }
                            // if (!ValidationUtils.isValidEmail(text)) {
                            //   return 'please enter a valid email';
                            // }
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
                        CustomFormField(
                            controller: passwordConfirmationController,
                            label: 'Password Confirmation',
                            hint: 'Re-Type password',
                            keyboardType: TextInputType.text,
                            isPassword: true,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'please enter password-confirmation';
                              }
                              if (passwordController.text != text) {
                                return "password doesn't match";
                              }
                            }),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              backgroundColor: Theme.of(context).primaryColor,
                              padding: EdgeInsets.symmetric(vertical: 12)),
                          onPressed: () {
                            register();
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        TextButton(
                          onPressed: (){
                            Navigator.pushReplacementNamed(context,
                                LoginScreen.routeName);
                          },child: Text('Already have account ? login',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },

    );
  }

  void register() async {
    // async - await
    if (formKey.currentState?.validate() == false) {
      return;
    }
    viewModel.register(nameController.text,
        emailController.text,
        passwordController.text,
        passwordConfirmationController.text,
        mobileController.text);
  }
}
