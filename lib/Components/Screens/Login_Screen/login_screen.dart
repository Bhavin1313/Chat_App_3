import 'package:chat_app/Components/Model/signin_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Utils/global.dart';
import '../../Helper/auth_helper.dart';
import '../../Model/signup_model.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: h,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  height: h * .020,
                ),
                CircleAvatar(
                  radius: 150,
                  foregroundImage: AssetImage("lib/Assets/abcd.jpeg"),
                ),
                SizedBox(
                  height: h * .01,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Valid Email";
                          } else {
                            return null;
                          }
                        },
                        controller: Global.email_c,
                        onSaved: (val) {
                          Global.email = val!;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail),
                          hintText: "Enter Email",
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: h * .01,
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Valid Password";
                          } else {
                            return null;
                          }
                        },
                        controller: Global.pass_c,
                        onSaved: (val) {
                          Global.pass = val!;
                        },
                        obscureText: Global.show,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                Global.show = !Global.show;
                              });
                            },
                            icon: (Global.show)
                                ? Icon(Icons.remove_red_eye)
                                : Icon(Icons.remove_circle_outline),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.key),
                          hintText: "Enter Password",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: h * .01,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();

                            SignIn singIn = SignIn(
                              email: Global.email!,
                              pass: Global.pass!,
                            );

                            Map<String, dynamic> res = await Auth_Helper
                                .auth_helper
                                .signIn(data: singIn);

                            if (res['user'] != null) {
                              Get.offNamedUntil('/tab', (routes) => false);
                            } else if (res['error'] != null) {
                              Get.snackbar("Flutter Chat App", "Login Failed");
                            }

                            Global.email_c.clear();
                            Global.pass_c.clear();
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              )),
                          alignment: Alignment.center,
                          child: const Text(
                            "Sign in",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: h * .01,
                ),
                const Divider(),
                SizedBox(
                  height: h * .01,
                ),
                const Text(
                  "or continue with",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: h * .01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () async {
                        Map? res =
                            await Auth_Helper.auth_helper.signInWithGoogle();

                        if (res['user'] != null) {
                          Get.offNamedUntil('/tab', (routes) => false);
                        } else if (res['error'] != null) {
                          Get.snackbar("Flutter Chat App", "Login Failed");
                        }
                      },
                      child: Ink(
                        child: Card(
                          elevation: 3,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                image: AssetImage(
                                  "lib/Assets/google22.png",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        Map? res =
                            await Auth_Helper.auth_helper.AnnoynimousLogin();

                        if (res['user'] == null) {
                          Get.snackbar("Chat App", "Login Failed");
                        } else {
                          Get.offNamedUntil('/tab', (routes) => false);
                        }
                      },
                      child: Ink(
                        child: Card(
                          elevation: 3,
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                image: AssetImage(
                                  "lib/Assets/a.webp",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 3,
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: AssetImage(
                              "lib/Assets/fasebook2.jpg",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: h * .01,
                ),
                const Divider(),
                SizedBox(
                  height: h * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/signup');
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
