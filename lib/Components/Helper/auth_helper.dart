import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Model/signin_model.dart';
import '../Model/signup_model.dart';
import 'cloud_firestore_helper.dart';

class Auth_Helper {
  Auth_Helper._();

  static final Auth_Helper auth_helper = Auth_Helper._();

  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<Map> AnnoynimousLogin() async {
    Map res = {};

    try {
      UserCredential userCredential = await auth.signInAnonymously();
      res['user'] = userCredential.user;
    } on FirebaseAuthException catch (e) {
      res['error'] = e.code;
    }
    return res;
  }

  Future<Map<String, dynamic>> signUp({required SignUp_model data}) async {
    Map<String, dynamic> res = {};
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: data.s_email,
        password: data.s_pass,
      );

      res['user'] = userCredential.user;
    } on FirebaseAuthException catch (e) {
      res['error'] = e.code;
    }
    return res;
  }

  Future<Map<String, dynamic>> signIn({required SignIn data}) async {
    Map<String, dynamic> res = {};
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: data.email, password: data.pass);

      Firestore_Helper.firestore_helper.addUser(user_data: {
        "name": (userCredential.user?.displayName == null)
            ? userCredential.user?.email?.split("@")[0]
            : userCredential.user?.displayName,
        "email": userCredential.user?.email,
        "photo": (userCredential.user?.photoURL == null)
            ? "https://img.freepik.com/premium-photo/panda-suit-tie-with-cup-coffee-generative-ai_634053-4050.jpg"
            : userCredential.user?.photoURL,
        "uid": userCredential.user?.uid,
      });

      res['user'] = userCredential.user;
    } on FirebaseAuthException catch (e) {
      res['error'] = e.code;
    }
    return res;
  }

  Future<Map<String, dynamic>> signInWithGoogle() async {
    Map<String, dynamic> res = {};
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await auth.signInWithCredential(credential);

      Firestore_Helper.firestore_helper.addUser(user_data: {
        "name": userCredential.user?.displayName,
        "email": userCredential.user?.email,
        "photo": userCredential.user?.photoURL,
        "uid": userCredential.user?.uid,
      });

      res['user'] = userCredential.user;
    } on FirebaseAuthException catch (e) {
      res['error'] = e.code;
    }
    return res;
  }

  void signOut() async {
    await auth.signOut();
    await googleSignIn.signOut();
  }
}
