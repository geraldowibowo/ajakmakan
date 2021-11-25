import 'package:ajak_makan/services/database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'dart:io';

class ProfilePicture extends StatefulWidget {
  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  final _authUID = FirebaseAuth.instance.currentUser.uid;
  String imagePath;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    imagePath = await DatabaseService.downloadImage(
        destination: 'customers/$_authUID/profilePicture');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: CircleBorder(),
      elevation: 5,
      child: GestureDetector(
        onTap: () async {
          XFile file = await getImage();
          // print('NAME OF FILE: ${File(file.path)}');
          // print('Current user: $_authUID');
          // print('NAME OF FILE AT LOCAL: ${File(file.path)}');
          imagePath = await DatabaseService.uploadImage(
              imageFile: file,
              destination: 'customers/$_authUID/profilePicture');
          // print('NAME OF FILE AT FIREBASE: ${imagePath}');
          setState(() {});
        },
        child: CircleAvatar(
          radius: 60,
          backgroundImage: imagePath != null
              ? NetworkImage(imagePath)
              : AssetImage('assets/images/profilepic.png'),
        ),
      ),
    );
  }
}

Future<XFile> getImage() async {
  return await ImagePicker().pickImage(source: ImageSource.gallery);
}
