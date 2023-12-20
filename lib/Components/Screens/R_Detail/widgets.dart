import 'package:flutter/material.dart';

class MyWidgets {
  static Builder myrow() {
    return Builder(builder: (context) {
      double hi = MediaQuery.of(context).size.height;
      double wi = MediaQuery.of(context).size.width;
      double h = hi * .1;
      double w = wi * .195;
      double iconsize = 30;
      double fontsize = 16;
      FontWeight fontWeight = FontWeight.w400;
      Color color = Colors.grey.withOpacity(0.4);
      MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceEvenly;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Builder(
            builder: (BuildContext context) => Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // boxShadow: [
                //   BoxShadow(
                //     offset: Offset(0, 0),
                //     blurRadius: 5,
                //     spreadRadius: 5,
                //   )
                // ],
                border: Border.all(width: 1, color: color),
                color: Colors.white,
              ),
              height: h,
              width: w,
              child: Column(
                mainAxisAlignment: mainAxisAlignment,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.call,
                    color: Colors.teal,
                    size: iconsize,
                  ),
                  Text(
                    "Audio",
                    style: TextStyle(
                      fontWeight: fontWeight,
                      fontSize: fontsize,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: h,
            width: w,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 1,
                color: color,
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.video_camera_back,
                  color: Colors.teal,
                  size: iconsize,
                ),
                Text(
                  "Video",
                  style: TextStyle(
                    fontWeight: fontWeight,
                    fontSize: fontsize,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: h,
            width: w,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 1, color: color),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_add,
                  color: Colors.teal,
                  size: iconsize,
                ),
                Text(
                  "Add",
                  style: TextStyle(
                    fontWeight: fontWeight,
                    fontSize: fontsize,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: h,
            width: w,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 1,
                color: color,
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.search,
                  color: Colors.teal,
                  size: iconsize,
                ),
                Text(
                  "Search",
                  style: TextStyle(
                    fontWeight: fontWeight,
                    fontSize: fontsize,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
