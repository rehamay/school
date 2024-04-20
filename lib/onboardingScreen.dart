import 'package:flutter/material.dart';
import 'package:school/users_schools.dart';
import 'package:school/welcome.dart';


import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'introscreens/introPage1.dart';
import 'introscreens/introPage2.dart';
import 'introscreens/introPage3.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _controller = PageController();
  int pageCount = 4;
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            controller: _controller,
            children: [
              Welcome(),
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.95),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    if (currentPageIndex > 0) {
                      _controller.previousPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_back, color: Colors.blue, size: 30),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: pageCount,
                  effect: SlideEffect(
                    dotHeight: 12,
                    dotWidth: 12,
                    paintStyle: PaintingStyle.fill,
                    dotColor: Color(0xff90c4e8),
                    activeDotColor: Colors.blue,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (currentPageIndex < pageCount - 1) {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return UserSchool();
                        }),
                      );
                    }
                  },
                  child: Icon(
                    currentPageIndex == pageCount - 1
                        ? Icons.check_circle_outline
                        : Icons.arrow_forward,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




