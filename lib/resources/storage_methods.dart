import "dart:typed_data";

import "package:firebase_storage/firebase_storage.dart";
import "package:firebase_auth/firebase_auth.dart";


class StorageMethods{
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(String childName,Uint8List file,bool isPost)async{
    Reference ref = storage.ref().child(childName).child(auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}