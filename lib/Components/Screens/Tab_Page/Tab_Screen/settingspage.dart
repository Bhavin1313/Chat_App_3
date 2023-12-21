import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Helper/auth_helper.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  (Auth_Helper.auth_helper.auth.currentUser?.photoURL == null)
                      ? const CircleAvatar(
                          radius: 40,
                          foregroundImage: NetworkImage(
                            "https://img.freepik.com/premium-photo/panda-suit-tie-with-cup-coffee-generative-ai_634053-4050.jpg",
                          ),
                        )
                      : CircleAvatar(
                          radius: 40,
                          foregroundImage: NetworkImage(
                              "${Auth_Helper.auth_helper.auth.currentUser?.photoURL}"),
                        ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (Auth_Helper.auth_helper.auth.currentUser?.displayName ==
                              null)
                          ? (Auth_Helper.auth_helper.auth.currentUser?.email ==
                                  null)
                              ? const Text(
                                  "John Doe",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                )
                              : Text(
                                  "${Auth_Helper.auth_helper.auth.currentUser?.email?.split("@")[0]}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                )
                          : Text(
                              "NAME: ${Auth_Helper.auth_helper.auth.currentUser?.displayName}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                      const SizedBox(
                        height: 7,
                      ),
                      (Auth_Helper.auth_helper.auth.currentUser?.email == null)
                          ? const Text("JohnDoe@gmail.com")
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
                    child: const Icon(
                      Icons.key,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: w * .02,
                  ),
                  const Column(
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
                    child: const Icon(
                      Icons.lock,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: w * .02,
                  ),
                  const Column(
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
                    child: const Icon(
                      Icons.people_alt_outlined,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: w * .02,
                  ),
                  const Column(
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
                    child: const Icon(
                      Icons.chat,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: w * .02,
                  ),
                  const Column(
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
                    child: const Icon(
                      Icons.notifications,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: w * .02,
                  ),
                  const Column(
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
                    child: const Icon(
                      Icons.storage,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: w * .02,
                  ),
                  const Column(
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
                    child: const Icon(
                      Icons.language,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: w * .02,
                  ),
                  const Column(
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

                  Get.offNamedUntil('/login', (route) => false);
                },
                child: Row(
                  children: [
                    Container(
                      height: 75,
                      width: 75,
                      child: const Icon(
                        Icons.logout,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: w * .02,
                    ),
                    const Column(
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
      ),
    );
  }
}
