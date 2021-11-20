import 'package:flutter/material.dart';
import 'models/xm_database.dart';
import 'screens/boot_animatino.dart';
import 'package:xiaoman_application/src/screens/poetry.dart';
import 'package:dio/dio.dart';

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

void main(List<String> args) {
  runApp(const XiaoManApp());
}

class XiaoManApp extends StatefulWidget {
  const XiaoManApp({Key? key}) : super(key: key);

  @override
  _XiaoManAppState createState() => _XiaoManAppState();
}

class _XiaoManAppState extends State<XiaoManApp> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class XiaoManRoutePath {
  // "/poetry" "/music" "/article"
  String id = "/";

  bool get isPoetry => id == "/poetry";
  bool get isMusic => id == "/music";
  bool get isArticle => id == "/article";
}

class XiaoManRouterDelegate extends RouterDelegate<XiaoManRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<XiaoManRoutePath> {
  String nowPage = "/";

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
          const MaterialPage(
            key: ValueKey("poetryPage"),
            child: TestPage(),
          ),
      ],
    );
  }

  @override
  Future<void> setNewRoutePath(XiaoManRoutePath configuration) async {
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
