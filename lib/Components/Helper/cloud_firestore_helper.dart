import 'package:cloud_firestore/cloud_firestore.dart';

import '../Screens/ChatPage/Model/chatmodel.dart';
import 'auth_helper.dart';

class Firestore_Helper {
  Firestore_Helper._();

  static final Firestore_Helper firestore_helper = Firestore_Helper._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  addUser({required Map<String, dynamic> user_data}) async {
    await firestore
        .collection("user")
        .doc("${Auth_Helper.auth_helper.auth.currentUser?.uid}")
        .set(user_data);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchUser() {
    return firestore
        .collection("user")
        .where("uid",
            isNotEqualTo: Auth_Helper.auth_helper.auth.currentUser?.uid)
        .snapshots();
  }

  //todo:Delete User
  Future<void> deleteUser({required var deleteData}) async {
    await firestore.collection("user").doc("$deleteData").delete();
  }

  Future<void> sendMessage({required ChatDetails chatDetails}) async {
    await firestore
        .collection("chats")
        .doc("${chatDetails.receiverUid}_${chatDetails.senderUid}")
        .set({
      "sentby": chatDetails.senderUid,
      "receivedby": chatDetails.receiverUid,
      "message": chatDetails.message,
      "timestamp": FieldValue.serverTimestamp(),
    });
  }
}
