// import 'package:flutter/material.dart';
// import 'src/common/theme.dart';
// import 'src/screens/boot_animatino.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'xiaoman',
//       theme: appTheme,
//       home: const BootAnimation(),
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:xiaoman_application/src/screens/home.dart';
import 'src/models/xm_database.dart';
import 'src/screens/boot_animatino.dart';
import 'package:xiaoman_application/src/screens/poetry.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main(List<String> args) {
  runApp(const XiaoManApp());
}

class XiaoManApp extends StatefulWidget {
  const XiaoManApp({Key? key}) : super(key: key);

  @override
  _XiaoManAppState createState() => _XiaoManAppState();
}

class _XiaoManAppState extends State<XiaoManApp> with ChangeNotifier {
  final XiaoManRouterDelegate _routerDelegate = XiaoManRouterDelegate();
  final XiaoManRouteInformationParser _routeInformationParser =
      XiaoManRouteInformationParser();

  @override
  void initState() {
    // startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "XiaoMan App",
      routeInformationParser: _routeInformationParser,
      routerDelegate: _routerDelegate,
    );
  }
}

class XiaoManRoutePath {
  // "/poetry" "/music" "/article"
  String id = "/";

  bool get isPoetry => id == "/poetry";
  bool get isMusic => id == "/music";
  bool get isArticle => id == "/article";

  XiaoManRoutePath.poetry() : id = "/poetry";
  XiaoManRoutePath.music() : id = "/music";
  XiaoManRoutePath.article() : id = "/article";
  XiaoManRoutePath.home() : id = "/";
}

class XiaoManRouterDelegate extends RouterDelegate<XiaoManRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<XiaoManRoutePath> {
  Poetry poetry = Poetry(
      id: 0, date: "date", content: "", author: "author", likes: 0, shares: 0);
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
  String nowPage = "/";
  late Timer _timer;
  int timeoutCnt = 0;
  void tCallBack() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      timeoutCnt++;
      print("time cnt : $timeoutCnt");
      if ((timeoutCnt >= 10) && (poetry.id != 0)) {
        _timer.cancel();
        nowPage = "/poetry";
        notifyListeners();
        // Navigator.push(context, _createRounte(poetry, music, article));
      } else if (timeoutCnt > 50) {
        if (timeoutCnt == 51) {
          Fluttertoast.showToast(
              msg: "网络超时，请稍后重试",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black45,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    });
  }

  void startTimer() async {
    var _duration = const Duration(milliseconds: 100);
    Timer(_duration, tCallBack);
  }

  @override
  void addListener(VoidCallback listener) {
    dataManager(poetry, music, article);
    startTimer();
    // TODO: implement addListener
    super.addListener(listener);
  }

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  XiaoManRouterDelegate() : navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (nowPage == "/")
          const MaterialPage(
            key: ValueKey("bootAnimation"),
            child: BootAnimation(),
          ),
        if (nowPage == "/poetry")
          MaterialPage(
            key: ValueKey("poetryPage"),
            child: HomePage(
              poetry: poetry,
              music: music,
              article: article,
            ),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        return false;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(XiaoManRoutePath configuration) async {
    // print("set new Route");
    if (configuration.isPoetry) {
      nowPage = "/poetry";
    } else if (configuration.isArticle) {
      nowPage = "/article";
    } else if (configuration.isMusic) {
      nowPage = "/music";
    } else {
      nowPage = "/";
    }
    return;
  }
}

class XiaoManRouteInformationParser
    extends RouteInformationParser<XiaoManRoutePath> {
  int len = 0;
  @override
  Future<XiaoManRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location.toString());
    if (uri.pathSegments.isEmpty) {
      print("uri is empty");
      return XiaoManRoutePath.home();
    }
    len = uri.pathSegments.length;
    print("pathLen: $len");
    return XiaoManRoutePath.poetry();
  }

  @override
  RouteInformation? restoreRouteInformation(XiaoManRoutePath configuration) {
    if (configuration.isArticle) {
      return const RouteInformation(location: "/article");
    }
    if (configuration.isMusic) {
      return const RouteInformation(location: "/music");
    }
    if (configuration.isPoetry) {
      return const RouteInformation(location: "/poetry");
    }
    return null;
  }
}
