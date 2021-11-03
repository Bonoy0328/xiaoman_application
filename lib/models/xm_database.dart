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
