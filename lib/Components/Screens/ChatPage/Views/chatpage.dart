import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Helper/auth_helper.dart';
import '../../../Helper/cloud_firestore_helper.dart';
import '../../../Stream/stream.dart';
import '../Model/chatmodel.dart';
import '../Model/receiver_model.dart';

// ignore: must_be_immutable, camel_case_types
class Chat_Screen extends StatefulWidget {
  Chat_Screen({super.key});

  @override
  State<Chat_Screen> createState() => _Chat_ScreenState();
}

class _Chat_ScreenState extends State<Chat_Screen> {
  TextEditingController messageController = TextEditingController();
  ImagePicker picker = ImagePicker();
  File? image;

  String? message;
  String? imgUrl;

  @override
  Widget build(BuildContext context) {
    Receiver receiver = ModalRoute.of(context)!.settings.arguments as Receiver;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.withOpacity(.4),
        title: Text("${receiver.name}"),
        centerTitle: true,
        actions: [
          CircleAvatar(
            radius: 22,
            foregroundImage: NetworkImage("${receiver.photo}"),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(
            "https://t4.ftcdn.net/jpg/03/38/75/29/360_F_338752910_Th7euFDcjaI0nWNOBoi0JDSR0zu92WkM.jpg",
          ),
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: messageData,
                  builder: (ctx, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text("${snapshot.error}"));
                    } else if (snapshot.hasData) {
                      QuerySnapshot? querysnapshot = snapshot.data;
                      List<QueryDocumentSnapshot>? chats = querysnapshot?.docs;
                      return (chats!.isEmpty == true)
                          ? Center(
                              child: Text(
                                "No Chat Yet...",
                              ),
                            )
                          : ListView.builder(
                              reverse: true,
                              itemCount: chats.length,
                              itemBuilder: (ctx, i) {
                                return Row(
                                  mainAxisAlignment: (Auth_Helper.auth_helper
                                              .auth.currentUser?.uid ==
                                          chats[i]['sentby'])
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Chip(
                                            label:
                                                Text("${chats[i]['message']}")),
                                        (chats[i]['timestamp'] == null)
                                            ? Text(" ")
                                            : Text(
                                                "${chats[i]['timestamp'].toDate().toString().split(" ")[1].split(":")[0]}:"
                                                "${chats[i]['timestamp'].toDate().toString().split(" ")[1].split(":")[1]}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )
                                      ],
                                    ),
                                  ],
                                );
                              });
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              TextFormField(
                controller: messageController,
                onChanged: (val) {
                  message = val;
                },
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        builder: (ctx) {
                          return Container(
                            height: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      XFile? photo = await picker.pickImage(
                                          source: ImageSource.camera);
                                      setState(() {
                                        image = File(photo!.path);
                                      });

                                      imgUrl = await Firestore_Helper
                                          .firestore_helper
                                          .uploadImage(image: image!);

                                      log("$imgUrl");
                                    },
                                    icon: Icon(
                                      Icons.camera_alt,
                                      size: 35,
                                    )),
                                IconButton(
                                  onPressed: () async {
                                    XFile? photo = await picker.pickImage(
                                        source: ImageSource.gallery);
                                    setState(() {
                                      image = File(photo!.path);
                                    });
                                  },
                                  icon: Icon(
                                    Icons.photo,
                                    size: 35,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.add,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    onPressed: () {
                      ChatDetails chatdetails = ChatDetails(
                        receiverUid: receiver.uid,
                        senderUid:
                            Auth_Helper.auth_helper.auth.currentUser!.uid,
                        message: message!,
                        image: imgUrl!,
                      );

                      Firestore_Helper.firestore_helper
                          .sendMessage(chatDetails: chatdetails);

                      messageController.clear();
                    },
                    icon: const Icon(Icons.send),
                  ),
                  hintText: "send message.....",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
