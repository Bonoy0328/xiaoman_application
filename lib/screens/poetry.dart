import 'package:flutter/material.dart';
import 'package:xiaoman_application/models/xm_database.dart';
import 'package:like_button/like_button.dart';
import 'package:sized_context/sized_context.dart';

class PoetryScreen extends StatefulWidget {
  Poetry poetry;

  PoetryScreen({
    Key? key,
    required this.poetry,
  }) : super(key: key);

  @override
  _PoetryScreenState createState() => _PoetryScreenState();
}

class _PoetryScreenState extends State<PoetryScreen> {
  double lineMarginTop = 10;
  late String poetryContent;

  @override
  void initState() {
    poetryContent = widget.poetry.content;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: context.heightPx * 0.18),
            child: Column(
              children: [
                Text(
                  poetryContent,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "zhanku",
                    fontSize: 20,
                    height: 1.5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: (context.heightPx -
                              (poetryContent.split("\n").length * 20 * 1.5 +
                                  context.heightPx * 0.18 +
                                  52)) *
                          0.35),
                  child: Container(
                    width: context.widthPx * 0.92,
                    height: 3,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.05),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.05),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 2),
                          ),
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LikeButton(
                        likeCount: 0,
                        countBuilder: (int? count, bool isLiked, String texts) {
                          var color = isLiked ? Color(0xFFF44336) : Colors.grey;
                          Widget result;
                          if (count == 0) {
                            result = Text(
                              "Like",
                              style: TextStyle(color: color),
                            );
                          } else {
                            result = Text(
                              texts,
                              style: TextStyle(color: color),
                            );
                          }
                          return result;
                        },
                      ),
                      SizedBox(
                        width: (context.widthPx - (30 * 2 + 15 * 8)) * 4 / 7,
                      ),
                      LikeButton(
                        size: 30,
                        circleColor: const CircleColor(
                            start: Color(0xff00ddff), end: Color(0xff0099cc)),
                        bubblesColor: const BubblesColor(
                          dotPrimaryColor: Color(0xff33b5e5),
                          dotSecondaryColor: Color(0xff0099cc),
                        ),
                        likeCount: 0,
                        countBuilder: (int? count, bool isLiked, String texts) {
                          var color =
                              isLiked ? Colors.deepPurpleAccent : Colors.grey;
                          Widget result;
                          if (count == 0) {
                            result = Text(
                              "Share",
                              style: TextStyle(color: color),
                            );
                          } else {
                            result = Text(
                              texts,
                              style: TextStyle(color: color),
                            );
                          }
                          return result;
                        },
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            Icons.share,
                            color:
                                isLiked ? Colors.deepPurpleAccent : Colors.grey,
                            size: 30,
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
