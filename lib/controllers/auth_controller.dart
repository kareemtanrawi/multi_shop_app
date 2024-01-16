import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AuthController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  ///finction to select image from gallery or Camera,

  pickProfileImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('No Image Selected or Cuptured');
    }
  }

  ///Function to upload image to firebase
  _uploadImageToStorage(Uint8List? image) async {
    Reference ref =
        _storage.ref().child('profileImages').child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> createNewUser(
      String email, String fullName, String password, Uint8List? image) async {
    String res = 'some error occur';
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String downLoadUrl = await _uploadImageToStorage(image);
      await _firestore.collection('buyers').doc(userCredential.user!.uid).set({
        'fullName': fullName,
        'profileImage': downLoadUrl,
        'email': email,
        'buyerId': userCredential.user!.uid,
      });
      res = 'success';
    } catch (e) {
      res.toString();
    }
    return res;
  }
}
