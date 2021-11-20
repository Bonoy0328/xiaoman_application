import 'package:flutter/material.dart';
import 'package:xiaoman_application/src/models/xm_database.dart';
import 'package:flutter/services.dart';
import 'package:sized_context/sized_context.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:xiaoman_application/src/screens/poetry.dart';

class HomePage extends StatefulWidget {
  Poetry poetry;
  Music music;
  Article article;
  HomePage({
    Key? key,
    required this.poetry,
    required this.music,
    required this.article,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController controller = PageController(initialPage: 0);
  double lineMarginTop = 10;
  int _lastPressedAt = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    var width = context.heightPx;
    return WillPopScope(
      onWillPop: () async {
        int nowExitTime = DateTime.now().millisecondsSinceEpoch;
        if (nowExitTime - _lastPressedAt > 2000) {
          _lastPressedAt = nowExitTime;
          Fluttertoast.showToast(
              msg: "再次点击退出",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black45,
              textColor: Colors.white,
              fontSize: 16.0);
          return await Future.value(false);
        } else {
          exit(0);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 52,
          automaticallyImplyLeading: false,
          centerTitle: false,
          titleSpacing: 0.0,
          elevation: 1.0,
          title: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: FractionalOffset.centerLeft,
                  child: TextButton(
                      onPressed: () => {},
                      child: SvgPicture.asset(
                        "assets/images/history.svg",
                        fit: BoxFit.cover,
                        width: context.widthPx * 0.06,
                      )),
                ),
              ),
              SvgPicture.asset(
                "assets/images/xiaoman.svg",
                fit: BoxFit.cover,
                width: context.widthPx / 6,
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.centerRight,
                  child: TextButton(
                      onPressed: () => {print("button test $width")},
                      child: SvgPicture.asset(
                        "assets/images/more.svg",
                        fit: BoxFit.cover,
                        width: context.widthPx * 0.06,
                      )),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
        ),
        body: PageView(
          scrollDirection: Axis.horizontal,
          controller: controller,
          children: [
            PoetryScreen(poetry: widget.poetry),
            PoetryScreen(poetry: widget.poetry),
            PoetryScreen(poetry: widget.poetry),
          ],
        ),
      ),
    );
  }
}
