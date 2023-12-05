import 'package:animate_do/animate_do.dart';
import 'package:esayshop/my_theme.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  static String routeName ='PrivacyPolicyScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy & Security',style: TextStyle(color: MyTheme.tittleproducttColor),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Privacy Matters',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'We are committed to protecting your privacy and ensuring the security of your personal information.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            ListTile(
              title: Text('Privacy Policy'),
              leading: Icon(Icons.lock),
              onTap: () {
                // Add logic to navigate to the detailed privacy policy screen
              },
            ),
            ListTile(
              title: Text('Manage Data'),
              leading: Icon(Icons.data_usage),
              onTap: () {
                // Add logic to navigate to the screen where users can manage their data
              },
            ),
            ListTile(
              title: Text('Security Settings'),
              leading: Icon(Icons.security),
              onTap: () {
                // Add logic to navigate to the security settings screen
              },
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
