import 'package:firebase_auth/firebase_auth.dart';

class Accounts{
  // Initialising firebase class
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Stream<FirebaseUser> get account{
    return _auth.onAuthStateChanged;
  }


  Future<FirebaseUser> registerUser(String email, String password) async{
    try{
      AuthResult user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return user.user;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  Future<FirebaseUser> loginUser(String email, String password) async{
    try{
      AuthResult user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return user.user  ;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  Future signOut() async{
    try{
      await _auth.signOut();
      return 'Success';
    }
    catch(e){
      return null;
    }
  }
  Future deleteUser() async{
    FirebaseUser user = await _auth.currentUser();
    await user.delete();
  }

  String validateId(String id)
  {
    if(id.isEmpty)
    {
      return "Email can't be blank";
    }
    else
    {
      return null;
    }
  }

  String validateRegisterPass(String pass)
  {
    if(pass.length < 8)
    {
      return "Password can't be less than 8 characters";
    }
    else
    {
      return null;
    }
  }

  String validateLoginPass(String pass)
  {
    if(pass.isEmpty)
    {
      return "Password can't be empty";
    }
    else
    {
      return null;
    }
  }
}