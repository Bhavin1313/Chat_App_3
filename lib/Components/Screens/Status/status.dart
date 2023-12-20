import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Status extends StatefulWidget {
  const Status({super.key});

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leadingWidth: 95,
        leading: Row(
          children: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_sharp,
                color: Colors.white,
              ),
            ),
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 20,
                foregroundImage: AssetImage("${data['image']}"),
              ),
            ),
          ],
        ),
        title: Text(
          "${data['name']}",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Container(
          height: h * .6,
          width: w * .9,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              "${data['image']}",
            ),
            fit: BoxFit.cover,
          )),
        ),
      ),
    );
  }
}
