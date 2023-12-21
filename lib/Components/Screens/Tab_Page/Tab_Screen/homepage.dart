import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Helper/auth_helper.dart';
import '../../../Helper/cloud_firestore_helper.dart';
import '../../../Stream/stream.dart';
import '../Model/chatmodel.dart';
import '../Model/receiver_model.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
        color: Colors.white,
        child: StreamBuilder(
          stream: Firestore_Helper.firestore_helper.fetchUser(),
          builder: (ctx, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              QuerySnapshot<Map<String, dynamic>>? querySnapshot =
                  snapshot.data;
              List<QueryDocumentSnapshot<Map<String, dynamic>>>? userData =
                  querySnapshot?.docs;

              return ListView.builder(
                itemCount: userData?.length,
                itemBuilder: (ctx, i) {
                  return Column(
                    children: [
                      GestureDetector(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 32,
                              backgroundColor: Colors.greenAccent,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 28,
                                  foregroundImage:
                                      NetworkImage("${userData?[i]['photo']}"),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: w * .04,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${userData?[i]['name']}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${userData?[i]['email']}",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                Firestore_Helper.firestore_helper.deleteUser(
                                    deleteData: "${userData?[i]['uid']}");
                              },
                              icon: Icon(
                                Icons.delete,
                              ),
                            ),
                          ],
                        ),
                        onTap: () async {
                          Receiver receiver = Receiver(
                            name: userData?[i]['name'],
                            uid: userData?[i]['uid'],
                            photo: userData?[i]['photo'],
                          );
                          ChatDetails chatdata = ChatDetails(
                              receiverUid: receiver.uid,
                              senderUid:
                                  Auth_Helper.auth_helper.auth.currentUser!.uid,
                              message: "");
                          messageData = await Firestore_Helper.firestore_helper
                              .displayMessage(chatDetails: chatdata);
                          Get.toNamed("/chat", arguments: receiver);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
