import 'package:flutter/material.dart';
import 'package:xiaoman_application/models/xm_database.dart';
import 'package:dio/dio.dart';

Future<void> testFuture() async {
  await Future.delayed(const Duration(seconds: 4));
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

  @override
  void initState() {
    testFuture();
    dataManager(poetry, music, article).then((_) {
      print(poetry.content);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: const Text("Boot animation test"),
    );
  }
}
