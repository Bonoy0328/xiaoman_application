import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class Poetry {
  int id;
  String date;
  String content;
  String author;
  int likes;
  int shares;

  Poetry(
      {required this.id,
      required this.date,
      required this.content,
      required this.author,
      required this.likes,
      required this.shares});
}

class Music {
  int id;
  String image;
  String file;
  String name;
  String author;
  String date;
  int likes;
  int shares;

  Music(
      {required this.id,
      required this.date,
      required this.image,
      required this.name,
      required this.author,
      required this.file,
      required this.likes,
      required this.shares});
}

class Article {
  int id;
  String date;
  String title;
  String author;
  String image;
  String content;
  int likes;
  int shares;

  Article(
      {required this.id,
      required this.date,
      required this.title,
      required this.author,
      required this.image,
      required this.content,
      required this.likes,
      required this.shares});
}

Future<void> dataManager(Poetry poetry, Music music, Article article) async {
  DateTime dateTime = DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(dateTime);
  bool isInitiateRequest = false;
  // String contentDate = " ";
  print(formattedDate.substring(0, 10));
  Dio dio = Dio();
  // check local time is match database time
  // if true don't initiate network request
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var contentDate = prefs.getString("contentDate");
  if (contentDate == null) {
    print("initiate request");
    isInitiateRequest = true;
  } else {}
// Date: "2021-6-2-21:58"
// ID: 1
// LikesNum: 2
// SharedNum: 5
// UpdatorName: "bonoy"
// poetryAuthor: "佚名"
// poetryContent: "我的豪迈烈骨给你看了，\n我的魅惑风情也被你收了，\n你要拿什么还我？\n诗人的情诗我自是不信的，\n我要你这浪子的余生。"
  Response response = await dio.get("https://www.bonoy0328.com/getPoetry");
  poetry.author = response.data["poetryAuthor"];
  poetry.content = response.data["poetryContent"];
  poetry.date = response.data["Date"];
  poetry.id = response.data["ID"];
  poetry.likes = response.data["LikesNum"];
  poetry.shares = response.data["SharedNum"];

  print(poetry.date.substring(0, 10));

// Date: "2021-6-8-21:21:21"
// ID: 1
// LikesNum: 1
// SharedNum: 3
// UpdatorName: "bonoy"
// anthorName: "bonoy"
// musicImg: "/usr/local/bonoy/media/music/img/Doja Cat; SZA - Kiss Me More.PNG"
// musicName: "Doja Cat; SZA - Kiss Me More"
// musicfile: "/usr/local/bonoy/media/music/musicFile/Doja Cat; SZA - Kiss Me More.mp3"
  response = await dio.get("https://www.bonoy0328.com/getMusic");
  music.id = response.data["ID"];
  music.date = response.data["Date"];
  music.file = response.data["musicfile"];
  music.image = response.data["musicImg"];
  music.author = response.data["anthorName"];
  music.name = response.data["musicName"];
  music.likes = response.data["LikesNum"];
  music.shares = response.data["SharedNum"];
  // download music to local
// ArticleAnthor: "me"
// Date: "2021-5-30-23:21:50"
// ID: 1
// LikesNum: 1
// SharedNum: 4
// UpdatorName: "bonoy"
// articleContent: "《印度哲学概论》至：“太子作狮子吼：‘我若不断生、老、病、死、优悲、苦恼，不得阿耨多罗三藐三菩提，要不还此。’”有感而作。我刚刚出了世，已经有了一个漆黑严密的圈儿，远远的罩定我，但是我不觉得。渐的我往外发展，就觉得有它限制阻抑着，并且它似乎也往里收缩─—好害怕啊！圈子里只有黑暗，苦恼悲伤。　　　　它往里收缩一点，我便起来沿着边儿奔走呼号一回。结果呢？它依旧严严密密的罩定我，我也只有屏声静气的，站在当中，不能再动。　　　　它又往里收缩一点，我又起来沿着边儿奔走呼号一回；回数多了，我也疲乏了，─—圈儿啊！难道我至终不能抵抗你？永远幽囚在这里面么？　　　　起来！忍耐！努力！　　　　呀！严密的圈儿，终竟裂了一缝。─—往外看时，圈子外只有光明，快乐，自由。─—只要我能跳出圈儿外！　　《印度哲学概论》至：“太子作狮子吼：‘我若不断生、老、病、死、优悲、苦恼，不得阿耨多罗三藐三菩提，要不还此。’”有感而作。我刚刚出了世，已经有了一个漆黑严密的圈儿，远远的罩定我，但是我不觉得。渐的我往外发展，就觉得有它限制阻抑着，并且它似乎也往里收缩─—好害怕啊！圈子里只有黑暗，苦恼悲伤。 　　它往里收缩一点，我便起来沿着边儿奔走呼号一回。结果呢？它依旧严严密密的罩定我，我也只有屏声静气的，站在当中，不能再动。 　　它又往里收缩一点，我又起来沿着边儿奔走呼号一回；回数多了，我也疲乏了，─—圈儿啊！难道我至终不能抵抗你？永远幽囚在这里面么？ 　　起来！忍耐！努力！　　 　　呀！严密的圈儿，终竟裂了一缝。─—往外看时，圈子外只有光明，快乐，自由。─—只要我能跳出圈儿外！ 　　前途有了希望了，我不是永远不能抵抗它，我不至于永远幽囚在这里面了。努力！忍耐！看我劈开了这苦恼悲伤，跳出圈儿外！"
// articleImg: "/usr/local/bonoy/media/article/img/Ydata_fAIvGPh.png"
// articleTitle: "我是你爸爸"
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
