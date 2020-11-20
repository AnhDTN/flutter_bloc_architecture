import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:demo_login/access/colors.dart';
import 'package:demo_login/access/images.dart';
import 'package:demo_login/login/view/login.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => IntroPage());
  }

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final viewPageController = PageController(initialPage: 0);

  static const _duration = const Duration(milliseconds: 500);
  static const _curve = Curves.ease;
  var currentPage = 0;
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 3000), (timer) {
      if (currentPage < 2) {
        viewPageController.animateToPage(currentPage + 1,
            duration: _duration, curve: _curve);
      } else {
        viewPageController.animateToPage(0, duration: _duration, curve: _curve);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 600,
            child: PageView.builder(
              controller: viewPageController,
              scrollDirection: Axis.horizontal,
              itemCount: rawData.length,
              physics: new AlwaysScrollableScrollPhysics(),
              onPageChanged: (index) {
                currentPage = index;
              },
              itemBuilder: (context, position) => ItemViewPage(
                  title: rawData[position]["title"],
                  content: rawData[position]["content"],
                  imageName: rawData[position]["image"]),
            ),
          ),
          Container(
            height: 20,
            child: DotIndicator(
              controller: viewPageController,
              itemCount: 3,
              color: Colors.purpleAccent,
              onPageSelected: (int page) => {
                viewPageController.animateToPage(page,
                    duration: _duration, curve: _curve)
              },
            ),
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 28, right: 28, top: 40),
              child: Container(
                height: 48,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(border: Border.all(width: 1,color: AppColors.blue100Color),borderRadius: BorderRadius.all(Radius.circular(6)),color: Colors.blue),
                child: Text(
                  "LOG IN",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())),
          )
        ],
      ),
    );
  }
}

class ItemViewPage extends StatefulWidget {
  final String title;
  final String content;
  final String imageName;

  const ItemViewPage({Key key, this.title, this.content, this.imageName})
      : super(key: key);

  @override
  _ItemViewPageState createState() => _ItemViewPageState();
}

class _ItemViewPageState extends State<ItemViewPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Image.asset(
            widget.imageName,
            height: 280,
            width: 280,
          ),
          margin: EdgeInsets.only(top: 60),
          alignment: Alignment.topCenter,
        ),
        Container(
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          margin: EdgeInsets.only(top: 44, bottom: 16),
        ),
        Padding(
          padding: const EdgeInsets.all(36),
          child: Text(
            widget.content,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
          ),
        )
      ],
    );
  }
}

class DotIndicator extends AnimatedWidget {
  final PageController controller;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  final Color color;
  static const double _kDotSize = 8.0;
  static const double _kMaxZoom = 2.0;
  static const double _kDotSpacing = 25.0;

  DotIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return Container(
      width: _kDotSpacing,
      child: Center(
        child: Material(
          color: color,
          type: MaterialType.circle,
          child: Container(
              width: _kDotSize * zoom,
              height: _kDotSize * zoom,
              child: InkWell(
                onTap: () => onPageSelected(index),
              )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}

var rawData = [
  {
    "title": "Explore the World",
    "content":
        "Classifieds are usually the first place you think of when you are getting ready to make a purchase.",
    "image": ImageName.image_1
  },
  {
    "title": "Discover Places with AR",
    "content":
        "You will see all the beauty that Maui has to offer and can have a great time for the entire family.",
    "image": ImageName.image_2
  },
  {
    "title": "Ready to Travel",
    "content":
        "Maui helicopter tours are a great way to see the island from a different perspective and have a fun adventure.",
    "image": ImageName.image_3
  },
];
