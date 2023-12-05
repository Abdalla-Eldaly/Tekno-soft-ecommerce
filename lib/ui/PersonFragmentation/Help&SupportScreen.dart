import 'package:esayshop/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import the services.dart package

class HelpAndSupportScreen extends StatefulWidget {
  static String routeName = 'support';

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support',
            style: TextStyle(color: MyTheme.tittleproducttColor)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Frequently Asked Questions:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildFAQ('Q: How do I reset my password?',
                'A: You can reset your password by going to the login screen and clicking on the "Forgot Password" link.'),
            _buildFAQ('Q: What do I do if the app crashes?',
                'A: Please report the issue through the app or contact our support team at abdalla90eldaly90@gmail.com.'),
            SizedBox(height: 16),
            Text(
              'Contact Information:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildContactInfo('Email: abdalla90eldaly90@gmail.com'),
            _buildContactInfo('Phone: +20 1012951616'),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQ(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(answer),
        ],
      ),
    );
  }

  Widget _buildContactInfo(String info) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: GestureDetector(
        onTap: () {
          String email = info.substring(7); // Remove 'Email: ' prefix
          copyToClipboard(email);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Copied to Clipboard: $email'),
            ),
          );
        },
        child: Text(
          info,
          style: TextStyle(
            fontSize: 16,
            color: Colors.blue, // Make the email clickable
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}
