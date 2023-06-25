import 'package:addycreates/views/buyers/nav_screens/widgets/phone_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top, left: 25, right: 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          'Now Bring , Home Made \nFood Home 🏠',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderMessScreen(),
                ),
              );
            },
            child: Container(
                child: Row(
              children: [
                Text('Food service'),
                Icon(
                  CupertinoIcons.heart_fill,
                  color: Colors.pink,
                ),
              ],
            )))
      ]),
    );
  }
}
