import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../Helper/auth_helper.dart';
import '../../../Helper/cloud_firestore_helper.dart';
import '../../../Stream/stream.dart';
import '../Model/chatmodel.dart';
import '../Model/receiver_model.dart';

// ignore: must_be_immutable, camel_case_types
class Chat_Screen extends StatelessWidget {
  Chat_Screen({super.key});
  TextEditingController messageController = TextEditingController();
  String? message;
  @override
  Widget build(BuildContext context) {
    Receiver receiver = ModalRoute.of(context)!.settings.arguments as Receiver;

    return Scaffold(
      appBar: AppBar(
        title: Text("${receiver.name}"),
        centerTitle: true,
        actions: [
          CircleAvatar(
            radius: 30,
            foregroundImage: NetworkImage("${receiver.photo}"),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: messageData,
                builder: (ctx, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else if (snapshot.hasData) {
                    QuerySnapshot? querysnapshot = snapshot.data;
                    List<QueryDocumentSnapshot>? chats = querysnapshot?.docs;

                    return ListView.builder(
                      itemCount: chats?.length,
                      itemBuilder: (ctx, i) {
                        return Chip(
                          label: Text(
                            "${chats?[i]['message']}",
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
            TextFormField(
              controller: messageController,
              onChanged: (val) {
                message = val;
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    ChatDetails chatdetails = ChatDetails(
                        receiverUid: receiver.uid,
                        senderUid:
                            Auth_Helper.auth_helper.auth.currentUser!.uid,
                        message: message!);

                    Firestore_Helper.firestore_helper
                        .sendMessage(chatDetails: chatdetails);

                    messageController.clear();
                  },
                  icon: const Icon(Icons.send),
                ),
                hintText: "send message.....",
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
