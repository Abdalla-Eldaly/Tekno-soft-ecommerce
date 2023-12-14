// import 'dart:io';
//
// import 'package:flutter/material.dart';
//
// import 'imagepickerFuncations.dart';
//
// class UserProfileImagePicker extends StatefulWidget {
//   const UserProfileImagePicker({super.key});
//
//   @override
//   State<UserProfileImagePicker> createState() => _UserProfileImagePickerState();
// }
//
// class _UserProfileImagePickerState extends State<UserProfileImagePicker> {
//   File? pickedImage;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         InkWell(
//           onTap: () {
//             showImagePickerBottomSheet(context);
//           },
//           child: CircleAvatar(
//             backgroundColor: Colors.grey.shade300,
//             backgroundImage:
//                 pickedImage == null ? null : FileImage(pickedImage!),
//             radius: 80,
//             child: Icon(
//               Icons.person,
//               size: MediaQuery.of(context).size.height * 0.125,
//               color: Colors.grey,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   void showImagePickerBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           child: Wrap(
//             children: <Widget>[
//               ListTile(
//                 leading: Icon(Icons.camera_alt_outlined),
//                 title: Text('Take Photo'),
//                 onTap: () async {
//                   File? temp = await ImageFuncation.cameraPicker();
//                   if (temp != null) {
//                     pickedImage=temp;
//                   }
//                   setState(() {
//
//                   });
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.photo_album_outlined),
//                 title: Text('Choose from Gallery'),
//                 onTap: () async{
//                   File? temp = await ImageFuncation.galleryPicker();
//                   if (temp != null) {
//                     pickedImage=temp;
//                   }
//                   setState(() {
//
//                   });},
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
