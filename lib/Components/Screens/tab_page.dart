import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Helper/auth_helper.dart';
import '../Helper/cloud_firestore_helper.dart';
import '../Stream/stream.dart';
import 'ChatPage/Model/chatmodel.dart';
import 'ChatPage/Model/receiver_model.dart';

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int initialIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat App",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.teal,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          initialIndex = 0;
                        });
                      },
                      child: Column(
                        children: [
                          Expanded(
                            flex: 15,
                            child: Container(
                              color: Colors.teal,
                              child: Center(
                                child: Text(
                                  "Chats",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: (initialIndex == 0)
                                  ? Colors.white
                                  : Colors.teal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          initialIndex = 1;
                        });
                      },
                      child: Column(
                        children: [
                          Expanded(
                            flex: 15,
                            child: Container(
                              color: Colors.teal,
                              child: Center(
                                child: Text(
                                  "Updates",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: (initialIndex == 1)
                                  ? Colors.white
                                  : Colors.teal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          initialIndex = 2;
                        });
                      },
                      child: Column(
                        children: [
                          Expanded(
                            flex: 15,
                            child: Container(
                              color: Colors.teal,
                              child: Center(
                                child: Text(
                                  "Settings",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: (initialIndex == 2)
                                  ? Colors.white
                                  : Colors.teal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 12,
            child: IndexedStack(
              index: initialIndex,
              children: [
                Container(
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
                        List<QueryDocumentSnapshot<Map<String, dynamic>>>?
                            userData = querySnapshot?.docs;

                        return ListView.builder(
                          itemCount: userData?.length,
                          itemBuilder: (ctx, i) {
                            return Card(
                              elevation: 0,
                              child: ListTile(
                                onTap: () async {
                                  Receiver receiver = Receiver(
                                      name: userData?[i]['name'],
                                      uid: userData?[i]['uid'],
                                      photo: userData?[i]['photo']);

                                  ChatDetails chatdata = ChatDetails(
                                      receiverUid: receiver.uid,
                                      senderUid: Auth_Helper
                                          .auth_helper.auth.currentUser!.uid,
                                      message: "");
                                  messageData = await Firestore_Helper
                                      .firestore_helper
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
                                        .deleteUser(
                                            deleteData:
                                                "${userData?[i]['uid']}");
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
                Center(
                  child: Container(
                    child: Text("page 2"),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          (Auth_Helper.auth_helper.auth.currentUser?.photoURL ==
                                  null)
                              ? CircleAvatar(
                                  radius: 40,
                                  foregroundImage: NetworkImage(
                                      "https://img.freepik.com/premium-photo/dog-suit-sunglasses-sits-chair_781958-1562.jpg"),
                                )
                              : CircleAvatar(
                                  radius: 40,
                                  foregroundImage: NetworkImage(
                                      "${Auth_Helper.auth_helper.auth.currentUser?.photoURL}"),
                                ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (Auth_Helper.auth_helper.auth.currentUser
                                          ?.displayName ==
                                      null)
                                  ? (Auth_Helper.auth_helper.auth.currentUser
                                              ?.email ==
                                          null)
                                      ? Text(
                                          "John Doe",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        )
                                      : Text(
                                          "${Auth_Helper.auth_helper.auth.currentUser?.email?.split("@")[0]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        )
                                  : Text(
                                      "NAME: ${Auth_Helper.auth_helper.auth.currentUser?.displayName}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                              SizedBox(
                                height: 7,
                              ),
                              (Auth_Helper.auth_helper.auth.currentUser
                                          ?.email ==
                                      null)
                                  ? Text("JohnDoe@gmail.com")
                                  : Text(
                                      "${Auth_Helper.auth_helper.auth.currentUser?.email}"),
                            ],
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            child: Icon(
                              Icons.key,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Account",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22,
                                ),
                              ),
                              Text(
                                "Security notifications",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            child: Icon(
                              Icons.lock,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Privacy",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22,
                                ),
                              ),
                              Text(
                                "Block contact",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            child: Icon(
                              Icons.people_alt_outlined,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Avatar",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22,
                                ),
                              ),
                              Text(
                                "Create, edit ,profile photo",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            child: Icon(
                              Icons.chat,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Chats",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22,
                                ),
                              ),
                              Text(
                                "Theme, wallpapers, chat history",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            child: Icon(
                              Icons.notifications,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Notifications",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22,
                                ),
                              ),
                              Text(
                                "Mwssage, group & call tones",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            child: Icon(
                              Icons.storage,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Storage and data",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22,
                                ),
                              ),
                              Text(
                                "Network usage, auto-download",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            child: Icon(
                              Icons.language,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "App Language",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22,
                                ),
                              ),
                              Text(
                                "English",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Auth_Helper.auth_helper.signOut();

                          Get.offNamedUntil('/', (route) => false);
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 75,
                              width: 75,
                              child: Icon(
                                Icons.logout,
                                size: 40,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Log Out",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 22,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
