import 'dart:io';
import 'package:chat_app/Components/Screens/Tab_Page/Tab_Screen/settingspage.dart';
import 'package:chat_app/Components/Screens/Tab_Page/Tab_Screen/updatepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../Helper/cloud_firestore_helper.dart';
import 'Tab_Screen/homepage.dart';

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
    ImagePicker picker = ImagePicker();
    File? image;

    String? imgUrl;

    List<Widget> page = [
      Home(),
      Update(),
      SettingsPage(),
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 60,
            title: Text(
              "Chat App",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.teal,
            actions: [
              SizedBox(
                width: 20,
              ),
              IconButton(
                onPressed: () async {
                  XFile? photo =
                      await picker.pickImage(source: ImageSource.camera);
                  setState(() {
                    image = File(photo!.path);
                  });
                  Get.back();
                  imgUrl = await Firestore_Helper.firestore_helper
                      .uploadImage(image: image!);
                },
                icon: Icon(Icons.camera_alt_outlined),
                color: Colors.white,
              ),
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.search,
                color: Colors.white,
              ),
              SizedBox(
                width: 20,
              ),
            ],
            bottom: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 4,
              tabs: [
                Tab(
                  child: Text(
                    "Chats",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Tab(
                  child: Text(
                    "Updates",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Tab(
                  child: Text(
                    "Settings",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: page,
          )),
    );
  }
}

//
// import 'dart:io';
//
// import 'package:chat_app/Utils/global.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../../Helper/auth_helper.dart';
// import '../../Helper/cloud_firestore_helper.dart';
// import '../../Stream/stream.dart';
//
// import 'Model/chatmodel.dart';
// import 'Model/receiver_model.dart';
// import 'Tab_Screen/homepage.dart';
//
// class TabPage extends StatefulWidget {
//   const TabPage({super.key});
//
//   @override
//   State<TabPage> createState() => _TabPageState();
// }
//
// class _TabPageState extends State<TabPage> {
//   int initialIndex = 0;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double h = MediaQuery.of(context).size.height;
//     double w = MediaQuery.of(context).size.width;
//     ImagePicker picker = ImagePicker();
//     File? image;
//
//     String? imgUrl;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Chat App",
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.teal,
//         actions: [
//           SizedBox(
//             width: 20,
//           ),
//           IconButton(
//             onPressed: () async {
//               XFile? photo = await picker.pickImage(source: ImageSource.camera);
//               setState(() {
//                 image = File(photo!.path);
//               });
//               Get.back();
//               imgUrl = await Firestore_Helper.firestore_helper
//                   .uploadImage(image: image!);
//             },
//             icon: Icon(Icons.camera_alt_outlined),
//             color: Colors.white,
//           ),
//           SizedBox(
//             width: 20,
//           ),
//           Icon(
//             Icons.search,
//             color: Colors.white,
//           ),
//           SizedBox(
//             width: 20,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             flex: 1,
//             child: Container(
//               color: Colors.teal,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           initialIndex = 0;
//                         });
//                       },
//                       child: Column(
//                         children: [
//                           Expanded(
//                             flex: 15,
//                             child: Container(
//                               color: Colors.teal,
//                               child: const Center(
//                                 child: Text(
//                                   "Chats",
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Container(
//                               color: (initialIndex == 0)
//                                   ? Colors.white
//                                   : Colors.teal,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           initialIndex = 1;
//                         });
//                       },
//                       child: Column(
//                         children: [
//                           Expanded(
//                             flex: 15,
//                             child: Container(
//                               color: Colors.teal,
//                               child: const Center(
//                                 child: Text(
//                                   "Updates",
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Container(
//                               color: (initialIndex == 1)
//                                   ? Colors.white
//                                   : Colors.teal,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           initialIndex = 2;
//                         });
//                       },
//                       child: Column(
//                         children: [
//                           Expanded(
//                             flex: 15,
//                             child: Container(
//                               color: Colors.teal,
//                               child: const Center(
//                                 child: Text(
//                                   "Settings",
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Container(
//                               color: (initialIndex == 2)
//                                   ? Colors.white
//                                   : Colors.teal,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 12,
//             child: IndexedStack(
//               index: initialIndex,
//               children: [
//                 Container(
//                   padding:
//                   EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
//                   color: Colors.white,
//                   child: StreamBuilder(
//                     stream: Firestore_Helper.firestore_helper.fetchUser(),
//                     builder: (ctx, snapshot) {
//                       if (snapshot.hasError) {
//                         return Center(
//                           child: Text("${snapshot.error}"),
//                         );
//                       } else if (snapshot.hasData) {
//                         QuerySnapshot<Map<String, dynamic>>? querySnapshot =
//                             snapshot.data;
//                         List<QueryDocumentSnapshot<Map<String, dynamic>>>?
//                         userData = querySnapshot?.docs;
//
//                         return ListView.builder(
//                           itemCount: userData?.length,
//                           itemBuilder: (ctx, i) {
//                             return Column(
//                               children: [
//                                 GestureDetector(
//                                   child: Row(
//                                     children: [
//                                       CircleAvatar(
//                                         radius: 32,
//                                         backgroundColor: Colors.greenAccent,
//                                         child: CircleAvatar(
//                                           radius: 30,
//                                           backgroundColor: Colors.white,
//                                           child: CircleAvatar(
//                                             radius: 28,
//                                             foregroundImage: NetworkImage(
//                                                 "${userData?[i]['photo']}"),
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: w * .04,
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             "${userData?[i]['name']}",
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 22,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: 5,
//                                           ),
//                                           Text(
//                                             "${userData?[i]['email']}",
//                                             style: TextStyle(
//                                               color: Colors.grey,
//                                               fontSize: 17,
//                                             ),
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                         ],
//                                       ),
//                                       Spacer(),
//                                       IconButton(
//                                         onPressed: () {
//                                           Firestore_Helper.firestore_helper
//                                               .deleteUser(
//                                               deleteData:
//                                               "${userData?[i]['uid']}");
//                                         },
//                                         icon: Icon(
//                                           Icons.delete,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   onTap: () async {
//                                     Receiver receiver = Receiver(
//                                       name: userData?[i]['name'],
//                                       uid: userData?[i]['uid'],
//                                       photo: userData?[i]['photo'],
//                                     );
//                                     ChatDetails chatdata = ChatDetails(
//                                         receiverUid: receiver.uid,
//                                         senderUid: Auth_Helper
//                                             .auth_helper.auth.currentUser!.uid,
//                                         message: "");
//                                     messageData = await Firestore_Helper
//                                         .firestore_helper
//                                         .displayMessage(chatDetails: chatdata);
//                                     Get.toNamed("/chat", arguments: receiver);
//                                   },
//                                 ),
//                                 SizedBox(
//                                   height: 20,
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       }
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     },
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           "Status",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w700,
//                             fontSize: 22,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Row(
//                           children: [
//                             Stack(
//                               children: [
//                                 GestureDetector(
//                                   onTap: () async {
//                                     XFile? photo = await picker.pickImage(
//                                         source: ImageSource.camera);
//                                     setState(() {
//                                       image = File(photo!.path);
//                                     });
//                                     Get.back();
//                                     imgUrl = await Firestore_Helper
//                                         .firestore_helper
//                                         .uploadImage(image: image!);
//                                   },
//                                   child: CircleAvatar(
//                                     radius: 30,
//                                     foregroundImage: NetworkImage(
//                                       "https://img.freepik.com/premium-photo/panda-suit-tie-with-cup-coffee-generative-ai_634053-4050.jpg",
//                                     ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   bottom: 0,
//                                   right: 0,
//                                   child: CircleAvatar(
//                                     radius: 11,
//                                     backgroundColor: Colors.teal,
//                                     child: Center(
//                                       child: Icon(
//                                         Icons.add,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "My status",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 22,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 7,
//                                 ),
//                                 Text(
//                                   "Tap to add status update",
//                                   style: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 17,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Text(
//                           "Recent updates",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 17,
//                             color: Colors.grey,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         ...status
//                             .map(
//                               (e) => Column(
//                             children: [
//                               GestureDetector(
//                                 onTap: () {
//                                   Get.toNamed("/status", arguments: e);
//                                 },
//                                 child: Row(
//                                   children: [
//                                     CircleAvatar(
//                                       radius: 32,
//                                       backgroundColor: Colors.greenAccent,
//                                       child: CircleAvatar(
//                                         radius: 30,
//                                         backgroundColor: Colors.white,
//                                         child: CircleAvatar(
//                                           radius: 28,
//                                           foregroundImage: AssetImage(
//                                             "${e['image']}",
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 20,
//                                     ),
//                                     Column(
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "${e['name']}",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 22,
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 5,
//                                         ),
//                                         Text(
//                                           "${e['time']}",
//                                           style: TextStyle(
//                                             color: Colors.grey,
//                                             fontSize: 17,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 20,
//                               ),
//                             ],
//                           ),
//                         )
//                             .toList(),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             (Auth_Helper.auth_helper.auth.currentUser
//                                 ?.photoURL ==
//                                 null)
//                                 ? const CircleAvatar(
//                               radius: 40,
//                               foregroundImage: NetworkImage(
//                                 "https://img.freepik.com/premium-photo/panda-suit-tie-with-cup-coffee-generative-ai_634053-4050.jpg",
//                               ),
//                             )
//                                 : CircleAvatar(
//                               radius: 40,
//                               foregroundImage: NetworkImage(
//                                   "${Auth_Helper.auth_helper.auth.currentUser?.photoURL}"),
//                             ),
//                             const SizedBox(
//                               width: 20,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 (Auth_Helper.auth_helper.auth.currentUser
//                                     ?.displayName ==
//                                     null)
//                                     ? (Auth_Helper.auth_helper.auth.currentUser
//                                     ?.email ==
//                                     null)
//                                     ? const Text(
//                                   "John Doe",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 22,
//                                   ),
//                                 )
//                                     : Text(
//                                   "${Auth_Helper.auth_helper.auth.currentUser?.email?.split("@")[0]}",
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 22,
//                                   ),
//                                 )
//                                     : Text(
//                                   "NAME: ${Auth_Helper.auth_helper.auth.currentUser?.displayName}",
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 22,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 7,
//                                 ),
//                                 (Auth_Helper.auth_helper.auth.currentUser
//                                     ?.email ==
//                                     null)
//                                     ? const Text("JohnDoe@gmail.com")
//                                     : Text(
//                                     "${Auth_Helper.auth_helper.auth.currentUser?.email}"),
//                               ],
//                             ),
//                           ],
//                         ),
//                         const Divider(),
//                         Row(
//                           children: [
//                             Container(
//                               height: 75,
//                               width: 75,
//                               child: const Icon(
//                                 Icons.key,
//                                 size: 40,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             SizedBox(
//                               width: w * .02,
//                             ),
//                             const Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Account",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 22,
//                                   ),
//                                 ),
//                                 Text(
//                                   "Security notifications",
//                                   style: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 17,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Container(
//                               height: 75,
//                               width: 75,
//                               child: const Icon(
//                                 Icons.lock,
//                                 size: 40,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             SizedBox(
//                               width: w * .02,
//                             ),
//                             const Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Privacy",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 22,
//                                   ),
//                                 ),
//                                 Text(
//                                   "Block contact",
//                                   style: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 17,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Container(
//                               height: 75,
//                               width: 75,
//                               child: const Icon(
//                                 Icons.people_alt_outlined,
//                                 size: 40,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             SizedBox(
//                               width: w * .02,
//                             ),
//                             const Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Avatar",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 22,
//                                   ),
//                                 ),
//                                 Text(
//                                   "Create, edit ,profile photo",
//                                   style: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 17,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Container(
//                               height: 75,
//                               width: 75,
//                               child: const Icon(
//                                 Icons.chat,
//                                 size: 40,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             SizedBox(
//                               width: w * .02,
//                             ),
//                             const Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Chats",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 22,
//                                   ),
//                                 ),
//                                 Text(
//                                   "Theme, wallpapers, chat history",
//                                   style: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 17,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Container(
//                               height: 75,
//                               width: 75,
//                               child: const Icon(
//                                 Icons.notifications,
//                                 size: 40,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             SizedBox(
//                               width: w * .02,
//                             ),
//                             const Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Notifications",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 22,
//                                   ),
//                                 ),
//                                 Text(
//                                   "Mwssage, group & call tones",
//                                   style: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 17,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Container(
//                               height: 75,
//                               width: 75,
//                               child: const Icon(
//                                 Icons.storage,
//                                 size: 40,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             SizedBox(
//                               width: w * .02,
//                             ),
//                             const Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Storage and data",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 22,
//                                   ),
//                                 ),
//                                 Text(
//                                   "Network usage, auto-download",
//                                   style: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 17,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Container(
//                               height: 75,
//                               width: 75,
//                               child: const Icon(
//                                 Icons.language,
//                                 size: 40,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             SizedBox(
//                               width: w * .02,
//                             ),
//                             const Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "App Language",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 22,
//                                   ),
//                                 ),
//                                 Text(
//                                   "English",
//                                   style: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 17,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             Auth_Helper.auth_helper.signOut();
//
//                             Get.offNamedUntil('/login', (route) => false);
//                           },
//                           child: Row(
//                             children: [
//                               Container(
//                                 height: 75,
//                                 width: 75,
//                                 child: const Icon(
//                                   Icons.logout,
//                                   size: 40,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: w * .02,
//                               ),
//                               const Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Log Out",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 22,
//                                       color: Colors.red,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
