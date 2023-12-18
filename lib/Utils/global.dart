import 'package:flutter/cupertino.dart';

class Global {
  static bool show = true;

  static String? signup_email;
  static String? signup_pass;
  static String? signup_fname;
  static String? signup_lname;
  static TextEditingController signup_email_c = TextEditingController();
  static TextEditingController signup_pass_c = TextEditingController();
  static TextEditingController signup_fname_c = TextEditingController();
  static TextEditingController signup_lname_c = TextEditingController();

  static String? email;
  static String? pass;
  static TextEditingController email_c = TextEditingController();
  static TextEditingController pass_c = TextEditingController();
}
