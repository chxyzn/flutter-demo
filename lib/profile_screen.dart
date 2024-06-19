import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/api_calls_login.dart';
import 'package:flutter_app/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

                      var pathToSaveImage =
                          (await getApplicationDocumentsDirectory()).path;

                      String photoName = basename(photo!.path);

                      String pathToSave = '$pathToSaveImage/$photoName';

                      photo.saveTo(pathToSave);

                      await EncryptedStorage().write('image', pathToSave);

                      setState(() {
                        profilePicturePath = pathToSave;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      color: Colors.blue,
                      child: const Center(
                        child: Text('Upload your photo'),
                      ),
                    ),
                  ),
                );
              });
        },
        child: CircleAvatar(
          radius: 200,
          foregroundImage: (profilePicturePath != null)
              ? FileImage((File(profilePicturePath ?? '')))
              : null,
          child: const Icon(
            Icons.account_box,
            size: 100,
          ),
        ),
      ),
    );
  }
}
