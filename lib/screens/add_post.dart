import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_insta/models/user_model.dart';
import 'package:my_insta/providers/user_provider.dart';
import 'package:my_insta/resources/firestore_methods.dart';
import 'package:my_insta/utils/colors.dart';
import 'package:my_insta/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostSCreen extends StatefulWidget {
  const AddPostSCreen({super.key});

  @override
  State<AddPostSCreen> createState() => _AddPostSCreenState();
}

class _AddPostSCreenState extends State<AddPostSCreen> {
  Uint8List? _file;
  final TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;

  void postImage(String uid, String username, String profileImage) async {
    try {
      setState(() {
        isLoading = true;
      });
      String res = await FirestoreMethods().uploadPost(
          descriptionController.text, _file!, uid, username, profileImage);
          if(res=='success'){
            setState(() {
              isLoading = false;
            });
            clearImage();
            showSnackBar('posted', context);
          }
          else{
            showSnackBar(res, context);
          }
    } catch (err) {
      showSnackBar(err.toString(), context);
    }

  }

  selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('create post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    print("hello");
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    print("hello");
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

 void clearImage(){
  setState(() {
    _file = null;
  });
 }
  @override
  void dispose() {
    descriptionController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel userModel = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Center(
            child: IconButton(
                onPressed: () {
                  selectImage(context);
                },
                icon: const Icon(Icons.upload)),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobilebackgroundColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  clearImage();
                },
              ),
              title: const Text('post to'),
              centerTitle: false,
              actions: [
                TextButton(
                    onPressed: () {
                      postImage(userModel.uid, userModel.username,
                          userModel.photoUrl);
                    },
                    child: const Text(
                      'post',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ))
              ],
            ),
            body: Column(
              children: [
              isLoading ?const LinearProgressIndicator(): const Padding(padding: EdgeInsets.only(top: 0)),
             const  Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(userModel.photoUrl),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.height * 0.3,
                      child: TextField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          hintText: 'Write a caption',
                          border: InputBorder.none,
                        ),
                        maxLines: 5,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: MemoryImage(_file!),
                                  fit: BoxFit.fill,
                                  alignment: FractionalOffset.topCenter)),
                        ),
                      ),
                    )
                  ],
                ),
                const Divider(),
              ],
            ),
          );
  }
}
