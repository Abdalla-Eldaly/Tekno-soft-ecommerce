import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:share/share.dart';

import '../auth/login/Login.dart';
import 'Help&SupportScreen.dart';

class PersonTab extends StatelessWidget {
  const PersonTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(onPressed: () async {
      //     GoogleSignIn googleSignIn =GoogleSignIn();
      //     googleSignIn.disconnect();
      //     await FirebaseAuth.instance.signOut();
      //     QuickAlert.show(
      //         context: context,
      //         type: QuickAlertType.warning,
      //         text: 'Are you sure',
      //         confirmBtnText: 'Okey',
      //         onConfirmBtnTap: (){
      //           Navigator.pushReplacementNamed(context, Login.routeName);
      //         }
      //
      //
      //     );
      //
      //   }, icon: Icon(Icons.logout ),),
      // ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  CircleAvatar(
                    maxRadius: 65,
                    backgroundColor: Colors.grey.shade300,
                    child: Icon(Icons.person,size: MediaQuery.of(context).size.height*.130,color: Colors.grey,),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Thomas Shelby",
                    style:
                    TextStyle(fontWeight: FontWeight.w900, fontSize: 26),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Text("@peakyBlinders")],
              ),
              const SizedBox(
                height: 15,
              ),

              Column(
                children: [
                  Card(
                    margin:
                    const EdgeInsets.only( bottom: 10),
                    color: Colors.white70,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: const ListTile(
                      leading: Icon(
                        Icons.privacy_tip_sharp,
                        color: Colors.black54,
                      ),
                      title: Text(
                        'Privacy',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Card(
                    color: Colors.white70,
                    margin:
                    const EdgeInsets.only( bottom: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child:  ListTile(
                      onTap: (){
                        Navigator.pushNamed(context, HelpAndSupportScreen.routeName);
                      },
                      leading:
                      Icon(Icons.help_outline, color: Colors.black54),
                      title: Text(
                        'Help & Support',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    color: Colors.white70,
                    margin:
                    const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: const ListTile(
                      leading: Icon(
                        Icons.settings_applications_outlined,
                        color: Colors.black54,
                      ),
                      title: Text(
                        'Settings',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    color: Colors.white70,
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      onTap: () {
                        // Call the function to handle sharing
                        shareApp(context);
                      },
                      leading: Icon(
                        Icons.add_reaction_sharp,
                        color: Colors.black54,
                      ),
                      title: Text(
                        'Invite a Friend',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    color: Colors.white70,
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      onTap: () async {
                        GoogleSignIn googleSignIn = GoogleSignIn();
                        googleSignIn.disconnect();
                        await FirebaseAuth.instance.signOut();
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.warning,
                          text: 'Are you sure Logout ',
                          confirmBtnText: 'Okey',
                          onConfirmBtnTap: () {
                            Navigator.pushReplacementNamed(context, Login.routeName);
                          },
                        );
                      },
                      leading: Icon(
                        Icons.logout,
                        color: Colors.black54,
                      ),
                      title: Text(
                        'Logout',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                    ),
                  )

                ],
              )
            ],
          ),
        ),
      ),

    );
  }
  void shareApp(BuildContext context) {
    String appLink = 'https://github.com/Abdalla-Eldaly'; // Replace with your actual app link
    Share.share('Check out this awesome app! Download it from $appLink');

  }
}
