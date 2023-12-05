import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helper/auth_helper.dart';
import '../../Helper/cloud_firestore_helper.dart';
import '../../Stream/stream.dart';
import '../ChatPage/Model/chatmodel.dart';
import '../ChatPage/Model/receiver_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            (Auth_Helper.auth_helper.auth.currentUser?.photoURL == null)
                ? const CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 90,
                    child: CircleAvatar(
                      radius: 85,
                      foregroundImage: NetworkImage(
                          "https://img.freepik.com/premium-photo/dog-suit-sunglasses-sits-chair_781958-1562.jpg"),
                    ),
                  )
                : CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.orange,
                    child: CircleAvatar(
                      radius: 85,
                      foregroundImage: NetworkImage(
                          "${Auth_Helper.auth_helper.auth.currentUser?.photoURL}"),
                    ),
                  ),
            const Divider(),
            (Auth_Helper.auth_helper.auth.currentUser?.displayName == null)
                ? (Auth_Helper.auth_helper.auth.currentUser?.email == null)
                    ? Text("NAME: John Doe")
                    : Text(
                        "NAME: ${Auth_Helper.auth_helper.auth.currentUser?.email?.split("@")[0]}")
                : Text(
                    "NAME: ${Auth_Helper.auth_helper.auth.currentUser?.displayName}"),
            const Divider(),
            (Auth_Helper.auth_helper.auth.currentUser?.email == null)
                ? Text("EMAIL: JohnDoe@gmail.com")
                : Text(
                    "EMAIL: ${Auth_Helper.auth_helper.auth.currentUser?.email}"),
            const Divider(),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.withOpacity(.4),
        actions: [
          IconButton(
              onPressed: () {
                Auth_Helper.auth_helper.signOut();

                Get.offNamedUntil('/', (route) => false);
              },
              icon: const Icon(Icons.logout))
        ],
        title: (Auth_Helper.auth_helper.auth.currentUser?.displayName == null)
            ? (Auth_Helper.auth_helper.auth.currentUser?.email == null)
                ? Text("John Doe")
                : Text(
                    "${Auth_Helper.auth_helper.auth.currentUser?.email?.split("@")[0]}")
            : Text("${Auth_Helper.auth_helper.auth.currentUser?.displayName}"),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://t4.ftcdn.net/jpg/03/38/75/29/360_F_338752910_Th7euFDcjaI0nWNOBoi0JDSR0zu92WkM.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
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
                  return Card(
                    color: Colors.blueGrey.withOpacity(.5),
                    elevation: 0,
                    child: ListTile(
                      onTap: () async {
                        Receiver receiver = Receiver(
                            name: userData?[i]['name'],
                            uid: userData?[i]['uid'],
                            photo: userData?[i]['photo']);

                        ChatDetails chatdata = ChatDetails(
                            receiverUid: receiver.uid,
                            senderUid:
                                Auth_Helper.auth_helper.auth.currentUser!.uid,
                            message: "");
                        messageData = await Firestore_Helper.firestore_helper
                            .displayMessage(chatDetails: chatdata);
                        Get.toNamed("/chat", arguments: receiver);
                      },
                      title: Text("${userData?[i]['name']}"),
                      subtitle: Text("${userData?[i]['email']}"),
                      leading: CircleAvatar(
                        radius: 30,
                        foregroundImage:
                            NetworkImage("${userData?[i]['photo']}"),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Firestore_Helper.firestore_helper
                              .deleteUser(deleteData: "${userData?[i]['uid']}");
                        },
                        icon: Icon(Icons.delete_outline),
                      ),
                    ),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
