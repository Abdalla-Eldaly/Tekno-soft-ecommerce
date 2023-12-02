import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../auth/login/Login.dart';

class PersonTab extends StatelessWidget {
  const PersonTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () async {
          GoogleSignIn googleSignIn =GoogleSignIn();
          googleSignIn.disconnect();
          await FirebaseAuth.instance.signOut();
          Navigator.pushNamedAndRemoveUntil(context, Login.routeName, (route) => false);
        }, icon: Icon(Icons.logout),),
      ),
    );
  }
}
