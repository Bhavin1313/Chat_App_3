import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/global.dart';
import '../../Helper/auth_helper.dart';
import '../../Model/signup_model.dart';

class SignUp_Page extends StatelessWidget {
  SignUp_Page({super.key});
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                height: h * .35,
                width: w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://cdn.dribbble.com/users/8619169/screenshots/16514320/secure_login_gif.gif",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
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
                        // suffixIcon: IconButton(
                        //   onPressed: () {
                        //     setState(() {
                        //       Global.show = !Global.show;
                        //     });
                        //   },
                        //   icon: (Global.show)
                        //       ? Icon(Icons.remove_red_eye)
                        //       : Icon(Icons.remove_circle_outline),
                        // ),
                        prefixIcon: Icon(Icons.remove_red_eye),
                        hintText: "Enter Password",
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
                          );

                          Map<String, dynamic> res =
                              await Auth_Helper.auth_helper.signUp(data: data);

                          if (res['user'] != null) {
                            Get.offNamedUntil("/", (routes) => false);
                          }
                          Global.signup_pass_c.clear();
                          Global.signup_email_c.clear();
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
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
