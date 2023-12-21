import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/global.dart';
import '../../Helper/auth_helper.dart';
import '../../Model/signup_model.dart';

class SignUp_Page extends StatefulWidget {
  SignUp_Page({super.key});

  @override
  State<SignUp_Page> createState() => _SignUp_PageState();
}

class _SignUp_PageState extends State<SignUp_Page> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              CircleAvatar(
                radius: 130,
                foregroundImage: AssetImage("lib/Assets/abcd.jpeg"),
              ),
              SizedBox(
                height: 10,
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
                      controller: Global.signup_email_c,
                      onSaved: (val) {
                        Global.signup_email = val!;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        hintText: "Enter Email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Valid Password";
                        } else {
                          return null;
                        }
                      },
                      controller: Global.signup_pass_c,
                      onSaved: (val) {
                        Global.signup_pass = val!;
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
                        prefixIcon: Icon(Icons.key),
                        hintText: "Enter Password",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter First Name";
                        } else {
                          return null;
                        }
                      },
                      controller: Global.signup_fname_c,
                      onSaved: (val) {
                        Global.signup_fname = val!;
                      },
                      obscureText: Global.show,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail_outline_sharp),
                        hintText: "Enter  First Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Last Name";
                        } else {
                          return null;
                        }
                      },
                      controller: Global.signup_lname_c,
                      onSaved: (val) {
                        Global.signup_lname = val!;
                      },
                      obscureText: Global.show,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail_outline_sharp),
                        hintText: "Enter  Last Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();

                          SignUp_model data = SignUp_model(
                            s_email: Global.signup_email!,
                            s_pass: Global.signup_pass!,
                            s_f_name: Global.signup_fname!,
                            s_l_name: Global.signup_lname!,
                          );

                          Map<String, dynamic> res =
                              await Auth_Helper.auth_helper.signUp(data: data);

                          if (res['user'] != null) {
                            Get.offNamedUntil("/login", (routes) => false);
                          }
                          Global.signup_pass_c.clear();
                          Global.signup_email_c.clear();
                          Global.signup_fname_c.clear();
                          Global.signup_lname_c.clear();
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
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Sign Up",
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
            ],
          ),
        ),
      ),
    );
  }
}
