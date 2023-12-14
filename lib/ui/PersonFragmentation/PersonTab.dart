import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:share/share.dart';

import '../auth/login/Login.dart';
import 'Help&SupportScreen.dart';
import 'imagePicker/ImagePicker.dart';
import 'PrivacyPolicyScreen.dart';

class PersonTab extends StatelessWidget {
  const PersonTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User?>(
        future: FirebaseAuth.instance.authStateChanges().first,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data == null) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          maxRadius: 65,
                          backgroundColor: Colors.grey.shade300,
                          child: Icon(
                            Icons.person,
                            size: MediaQuery.of(context).size.height * .130,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Guest",
                          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 26),
                        )
                      ],
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          color: Colors.white70,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, PrivacyPolicyScreen.routeName);
                            },
                            leading: Icon(
                              Icons.privacy_tip_sharp,
                              color: Colors.black54,
                            ),
                            title: Text(
                              'Privacy',
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
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, HelpAndSupportScreen.routeName);
                            },
                            leading:
                            Icon(Icons.help_outline, color: Colors.black54),
                            title: Text(
                              'Help & Support',
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
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: const ListTile(
                            leading: Icon(
                              Icons.settings_applications_outlined,
                              color: Colors.black54,
                            ),
                            title: Text(
                              'Settings',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
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
            );
          } else {
            User user = snapshot.data!;
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (userSnapshot.hasError) {
                  return Center(child: Text('Error: ${userSnapshot.error}'));
                } else if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                maxRadius: 65,
                                backgroundColor: Colors.grey.shade300,
                                child: Icon(
                                  Icons.person,
                                  size: MediaQuery.of(context).size.height * .130,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                 "Guest",
                                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 26),
                              )
                            ],
                          ),

                          const SizedBox(
                            height: 15,
                          ),
                          Column(
                            children: [
                              Card(
                                margin: const EdgeInsets.only(bottom: 10),
                                color: Colors.white70,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pushNamed(context, PrivacyPolicyScreen.routeName);
                                  },
                                  leading: Icon(
                                    Icons.privacy_tip_sharp,
                                    color: Colors.black54,
                                  ),
                                  title: Text(
                                    'Privacy',
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
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pushNamed(context, HelpAndSupportScreen.routeName);
                                  },
                                  leading:
                                  Icon(Icons.help_outline, color: Colors.black54),
                                  title: Text(
                                    'Help & Support',
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
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: const ListTile(
                                  leading: Icon(
                                    Icons.settings_applications_outlined,
                                    color: Colors.black54,
                                  ),
                                  title: Text(
                                    'Settings',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
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
                  );
                } else {
                  String username = userSnapshot.data!.get('username');
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //UserProfileImagePicker()
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                username ?? "Guest",
                                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 26),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "@${user.email?.split('@')[0]}", // Use the part before '@' as the username
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Column(
                            children: [
                              Card(
                                margin: const EdgeInsets.only(bottom: 10),
                                color: Colors.white70,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pushNamed(context, PrivacyPolicyScreen.routeName);
                                  },
                                  leading: Icon(
                                    Icons.privacy_tip_sharp,
                                    color: Colors.black54,
                                  ),
                                  title: Text(
                                    'Privacy',
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
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pushNamed(context, HelpAndSupportScreen.routeName);
                                  },
                                  leading:
                                  Icon(Icons.help_outline, color: Colors.black54),
                                  title: Text(
                                    'Help & Support',
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
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: const ListTile(
                                  leading: Icon(
                                    Icons.settings_applications_outlined,
                                    color: Colors.black54,
                                  ),
                                  title: Text(
                                    'Settings',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
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
                  );
                }
              },
            );
          }
        },
      ),
    );
  }

  void shareApp(BuildContext context) {
    String appLink = 'https://github.com/Abdalla-Eldaly';
    Share.share('Check out this awesome app! Download it from $appLink');
  }
}
