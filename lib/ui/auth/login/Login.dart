import 'package:esayshop/ui/auth/register/Register.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animate_do/animate_do.dart';

import '../../../di/di.dart';
import '../dialigoUtli/DilaogUtali.dart';
import 'LoginViewModel.dart';
import 'package:esayshop/ui/homeFragmentation/homePage/HomeScreen.dart';

class Login extends StatefulWidget {
  static String routeName = 'login';

  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController(text: "abdalla90eldaly90@gmail.com");
  final _passwordController = TextEditingController(text: '1234562@adfS');
  final _formKey = GlobalKey<FormState>();
  DialogUtils dialogUtils = DialogUtils(); // Renamed to follow Dart conventions
  var viewModel = getIt<LoginViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: _buildContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: [
            Colors.blue.shade900,
            Colors.blueAccent,
            Colors.blue.shade200
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeInUp(
                  duration: const Duration(milliseconds: 1000),
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
                const SizedBox(height: 10),
                FadeInUp(
                  duration: const Duration(milliseconds: 1300),
                  child: const Text(
                    "Welcome Back",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60),
                topRight: Radius.circular(60),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: _buildLoginForm(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 60),
          FadeInUp(
            duration: const Duration(milliseconds: 1400),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(108, 124, 231, 1.0),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  )
                ],
              ),
              child: Column(
                children: <Widget>[
                  _buildTextField(
                    controller: _emailController,
                    hintText: "Email or Phone number",
                  ),
                  _buildTextField(
                    controller: _passwordController,
                    hintText: "Password",
                    obscureText: true,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          FadeInUp(
            duration: const Duration(milliseconds: 1500),
            child: Text(
              "Forgot Password?",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 40),
          FadeInUp(
            duration: const Duration(milliseconds: 1600),
            child: MaterialButton(
              onPressed: loginPress,
              height: 50,
              color: Colors.blue[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          const SizedBox(height: 15),
          FadeInUp(
            duration: const Duration(milliseconds: 1700),
            child: const Text(
              "Continue with social media",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 20),
          _buildSocialMediaButtons(),
          const SizedBox(height: 30),
          InkWell(
            onTap: (){
              Navigator.pushReplacementNamed(context, Register.routeName);
            },
            child: FadeInUp(
              duration: const Duration(milliseconds: 1700),
              child: const Text(
                "Don't have an account ?",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildSocialMediaButtons() {
    return Row(
      children: <Widget>[
        Expanded(
          child: FadeInUp(
            duration: const Duration(milliseconds: 1800),
            child: MaterialButton(
              onPressed: () {},
              height: 50,
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Center(
                child: Text(
                  "Facebook",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: InkWell(
            onTap: (){signInWithGoogle();},
            child: FadeInUp(
              duration:  Duration(milliseconds: 1900),
              child: MaterialButton(
                onPressed: signInWithGoogle,
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                color: Color(0xFFE7094F),
                child: Center(
                  child: Text(
                    "Gmail",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future loginPress() async {
    if (_formKey.currentState!.validate()) {
      viewModel.loginPress();
    }

    try {
      dialogUtils.showLoading(context, 'Loading..');

      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      dialogUtils.hideDialog(context);
      dialogUtils.showMessage(
        context,
        message: 'Login Successfully',
        posActionTitle: 'Ok',
        posAction: () {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        },
      );
    } on FirebaseAuthException catch (e) {
      dialogUtils.hideDialog(context);
      dialogUtils.showMessage(
        context,
        message: 'Email or password is wrong',
        posActionTitle: 'ok',
      );
      if (e.code == 'user-not-found') {
        dialogUtils.showMessage(context, message: 'No user found for that email.', posActionTitle: 'Ok', );
      } else if (e.code == 'wrong-password') {
        dialogUtils.showMessage(context, message: 'Wrong password.', posActionTitle: 'Try Again');
      }
    }
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
