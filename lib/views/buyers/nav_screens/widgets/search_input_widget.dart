import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchInputWidget extends StatelessWidget {
  const SearchInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.white,
          padding:
              const EdgeInsets.fromLTRB(14.0, 14.0, 0, 14.0), // Updated padding

          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    0, 14, 0, 14), // child: SvgPicture.asset(
                //   // 'assets/icons/search.svg',
                //   // width: 10,
                // ),
              ),
              Expanded(
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                        'hello welcome order food now also u can start a daily service of food ',
                        textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        )),
                  ],
                  // repeatForever: true,
                  // // Set repeatForever to true
                  totalRepeatCount: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
