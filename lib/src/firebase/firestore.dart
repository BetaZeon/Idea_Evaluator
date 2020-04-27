import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AccountInfo{
  final FirebaseUser _user;

  AccountInfo(this._user);

  final CollectionReference _users = Firestore.instance.collection('users');

  Future<String> newUser(String userName, String type) async{
    try{
      await _users.document(_user.email).setData({
        'userName' : userName,
        'type' : type
      }, merge: true);
      return 'Success';
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  Future userInfo() async{
    DocumentSnapshot data;
    await _users.document(_user.email).get().then((DocumentSnapshot ds){
      data = ds;
    });
    return data.data;
  }

  Future changeProfileImage(File img) async{
    try{
      StorageReference storageReference = FirebaseStorage.instance.ref().child('profileImages/${_user.email}');
      StorageUploadTask uploadTask = storageReference.putFile(img);
      await uploadTask.onComplete;
      String url;
      await storageReference.getDownloadURL().then((fileURL) {
        url = fileURL.toString();
      });
      return url;
    }
    catch(e){
      return null;
    }
  }

  Future getProfileImage() async{
    try{
      StorageReference storageReference = FirebaseStorage.instance.ref().child('profileImages/${_user.email}');
      String url;
      await storageReference.getDownloadURL().then((fileURL) {
        url = fileURL.toString();
      });
      return url;
    }
    catch(e){
      return null;
    }
  }
}
