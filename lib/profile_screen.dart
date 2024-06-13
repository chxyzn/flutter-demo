import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isPhotoTaken = false;
  XFile imageFile = XFile('path');
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 380),
                  child: GestureDetector(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? photo =
                          await picker.pickImage(source: ImageSource.camera);

                      print(photo!.path);

                      setState(() {
                        imageFile = photo!;
                        isPhotoTaken = true;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      color: Colors.blue,
                      child: Center(
                        child: Text('Upload your photo'),
                      ),
                    ),
                  ),
                );
              });
        },
        child: CircleAvatar(
          radius: 200,
          child: (isPhotoTaken)
              ? CircleAvatar(
                  radius: 200,
                  backgroundImage: FileImage((File(imageFile.path))))
              : const Icon(
                  Icons.account_box,
                  size: 100,
                ),
        ),
      ),
    );
  }
}
