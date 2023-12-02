import 'package:animate_do/animate_do.dart';
import 'package:esayshop/di/di.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path/path.dart' as Path;
import '../../homeFragmentation/homePage/HomeScreen.dart';
import '../RegExp/RegExp.dart';
import '../dialigoUtli/DilaogUtali.dart';
import '../login/Login.dart';
import 'RegisterViewModel.dart';

class Register extends StatefulWidget {
  static String routeName = 'register';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  var viewModel = getIt<RedisterViewModel>();

  final _fullNameController = TextEditingController(text: 'Abdalla Eldaly');

  final _emailController = TextEditingController(text: "abdalla90eldaly90@gmail.com");

  final _passwordController = TextEditingController(text: '1234562@adfS');

  final _confirmPasswordController = TextEditingController(text: '1234562@adfS');

  DialogUtils dialogShown =DialogUtils();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 150,
                      child: FadeInUp(
                        duration: Duration(seconds: 1),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/light-1.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 120,
                      child: FadeInUp(
                        duration: Duration(milliseconds: 1200),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/light-2.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 120,
                      child: FadeInUp(
                        duration: Duration(milliseconds: 1300),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/clock.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    FadeInUp(
                      duration: Duration(milliseconds: 1800),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Color.fromRGBO(143, 148, 251, 1)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color.fromRGBO(
                                              143, 148, 251, 1))),
                                ),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'please enter your Name';
                                    }

                                    return null;
                                  },
                                  controller: _fullNameController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Full Name",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[700]),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color.fromRGBO(
                                              143, 148, 251, 1))),
                                ),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'please enter the email';
                                    }
                                    if (!InvalidEmail(value)) {
                                      return 'please enter valid email';
                                    }
                                    return null;
                                  },
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email or Phone number",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[700]),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'please enter Password';
                                    }
                                    if (!InvalidPassword(value)) {
                                      return 'Enter Strong Password';
                                    }
                                    return null;
                                  },
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[700]),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  obscureText: true,
                                  validator: (value) {
                                    if (_passwordController.text !=
                                        _confirmPasswordController.text) {
                                      return 'enter the same Password';
                                    }
                                    return null;
                                  },
                                  controller: _confirmPasswordController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password confirmation",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[700]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        CreatAccount();
                      },
                      child: FadeInUp(
                        duration: Duration(milliseconds: 1900),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(93, 131, 238, 1.0),
                                Color.fromRGBO(123, 137, 238, 0.6),
                              ],
                            ),
                          ),
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                CreatAccount();
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    InkWell(
                      onTap: (){

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Login();
                            },
                          ),
                        );

                      },
                      child: FadeInUp(
                        duration: Duration(milliseconds: 2000),
                        child: Text(
                          "Already have Account?",
                          style: TextStyle(
                              color: Color.fromRGBO(143, 148, 251, 1)),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void CreatAccount()async {
    if (_formKey.currentState!.validate()) {
      viewModel.creatAccount();
    }
    try {
      dialogShown.showLoading(context,'Loading..');
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if(result.user?.emailVerified ==false){
        User? user = FirebaseAuth.instance.currentUser;
        await user?.sendEmailVerification();
        dialogShown.hideDialog(context);
        dialogShown.showMessage(context, message: 'Register Succseesfully.',posActionTitle: 'OK',
        posAction: (){
          if(result.user!.emailVerified){
            Navigator.pushReplacementNamed(context, Login.routeName);
          }
          else{
            FirebaseAuth.instance.currentUser!.sendEmailVerification();

            dialogShown.showMessage(context, message: 'Verifiy your email.',posActionTitle: 'tryAgain',);

          }
        });

      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        dialogShown.showMessage(context, message: 'The password provided is too weak.',posActionTitle: 'OK',);

      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        dialogShown.hideDialog(context);

        dialogShown.showMessage(context, message: 'The account already exists for that email.',posActionTitle: 'tryAgain');
      }
    } catch (e) {
      print(e);
      dialogShown.showMessage(context, message: 'some thing wrong.',posActionTitle: 'OK');

    }



  }

}
