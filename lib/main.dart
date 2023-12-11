import 'package:chat_app/Components/Screens/HomePage/homepage.dart';
import 'package:chat_app/Components/Screens/Login_Screen/login_screen.dart';
import 'package:chat_app/Components/Screens/SignUp_Screen/singup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Components/Screens/ChatPage/Views/chatpage.dart';
import 'Components/Screens/tab_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      getPages: [
        GetPage(
          name: '/',
          page: () => LoginPage(),
        ),
        GetPage(
          name: '/signup',
          page: () => SignUp_Page(),
        ),
        GetPage(
          name: '/home',
          page: () => HomePage(),
        ),
        GetPage(
          name: '/chat',
          page: () => Chat_Screen(),
        ),
        GetPage(
          name: '/tab',
          page: () => TabPage(),
        ),
      ],
    ),
  );
}
