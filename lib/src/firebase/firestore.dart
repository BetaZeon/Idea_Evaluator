import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
}
