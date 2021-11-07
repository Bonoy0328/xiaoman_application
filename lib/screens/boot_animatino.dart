import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:xiaoman_application/models/xm_database.dart';
import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sized_context/sized_context.dart';
import 'package:xiaoman_application/screens/poetry.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> delayInit() async {
  await Future.delayed(const Duration(seconds: 2));
}

Future<void> dataManager(Poetry poetry, Music music, Article article) async {
  Dio dio = Dio();
  Response response = await dio.get("https://www.bonoy0328.com/getPoetry");
  poetry.author = response.data["poetryAuthor"];
  poetry.content = response.data["poetryContent"];
  poetry.date = response.data["Date"];
  poetry.id = response.data["ID"];
  poetry.likes = response.data["LikesNum"];
  poetry.shares = response.data["SharedNum"];

  response = await dio.get("https://www.bonoy0328.com/getMusic");
  music.id = response.data["ID"];
  music.date = response.data["Date"];
  music.file = response.data["musicfile"];
  music.image = response.data["musicImg"];
  music.author = response.data["anthorName"];
  music.name = response.data["musicName"];
  music.likes = response.data["LikesNum"];
  music.shares = response.data["SharedNum"];

  response = await dio.get("https://www.bonoy0328.com/getArticle");
  article.author = response.data["ArticleAnthor"];
  article.content = response.data["articleContent"];
  article.date = response.data["Date"];
  article.id = response.data["ID"];
  article.image = response.data["articleImg"];
  article.title = response.data["articleTitle"];
  article.likes = response.data["LikesNum"];
  article.shares = response.data["SharedNum"];
}

class BootAnimation extends StatefulWidget {
  const BootAnimation({Key? key}) : super(key: key);

  @override
  _BootAnimationState createState() => _BootAnimationState();
}

class _BootAnimationState extends State<BootAnimation> {
  double lineMarginTop = 10;
  int _lastPressedAt = 0;
  late Timer _timer;
  bool initSuccess = false;
  int timeoutCnt = 0;
  Poetry poetry = Poetry(
      id: 0,
      date: "date",
      content: "content",
      author: "author",
      likes: 0,
      shares: 0);

  Music music = Music(
      id: 0,
      date: "date",
      image: "image",
      name: "name",
      author: "author",
      file: "file",
      likes: 0,
      shares: 0);

  Article article = Article(
      id: 0,
      date: "date",
      title: "title",
      author: "author",
      image: "image",
      content: "content",
      likes: 0,
      shares: 0);

  void tCallBack() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (initSuccess) {
        timeoutCnt++;
        print("time cnt : $timeoutCnt");
        if (timeoutCnt >= 10) {
          _timer.cancel();
          Navigator.push(context, _createRounte(poetry, music, article));
        }
      }
    });
  }

  void startTimer() async {
    var _duration = const Duration(milliseconds: 100);
    Timer(_duration, tCallBack);
  }

  @override
  void initState() {
    startTimer();
    // delayInit().then((value) => {
    //       if (initSuccess)
    //         {Navigator.push(context, _createRounte(poetry, music, article))}
    //       else
    //         {startTimer()}
    //     });
    dataManager(poetry, music, article).then((_) {
      print(poetry.content);
      initSuccess = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
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
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFF3F3F1),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: context.widthPx * 0.5964),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/xiao.svg",
                    fit: BoxFit.cover,
                    width: context.widthPx * 0.152,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: context.widthPx * 0.152 * 0.5761,
                    ),
                    child: SvgPicture.asset(
                      "assets/images/man.svg",
                      fit: BoxFit.cover,
                      width: context.widthPx * 0.152,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SvgPicture.asset(
                    "assets/images/by.svg",
                    fit: BoxFit.cover,
                    width: context.widthPx * 0.1947,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Route _createRounte(Poetry poetry, Music music, Article article) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimatino) =>
          PoetryScreen(poetry: poetry, music: music, article: article),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var curve = Curves.ease;
        var curveTween = CurveTween(curve: curve);
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end).chain(curveTween);
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      });
}
