import 'package:flutter/material.dart';

typedef MyValidator = String? Function(String?);

class CustomFormField extends StatelessWidget {
  String label;
  String hint;
  bool isPassword;
  TextInputType keyboardType ;
  MyValidator validator;
  TextEditingController controller;
  int lines;
  CustomFormField({required this.label,
    required this.hint,
    required this.validator,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.lines=1
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
          style: TextStyle(
            color: Theme.of(context).primaryColor
          ),),
          SizedBox(height: 8,),
          TextFormField(
            maxLines: lines,
            minLines: lines,
            controller: controller,
            validator:validator,
            keyboardType: keyboardType,
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Theme.of(context).primaryColor
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Theme.of(context).primaryColor,width: 2)
              ),
              enabledBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor,width: 2)
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor,width: 2)
              )
            ),
          ),
        ],
      ),
    );
  }
}
