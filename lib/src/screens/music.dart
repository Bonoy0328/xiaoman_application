// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:like_button/like_button.dart';
// import 'package:sized_context/sized_context.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'dart:io';
// import 'dart:async';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:xiaoman_application/src/models/xm_database.dart';

// class MusicPage extends StatefulWidget {
//   late Music music;

//   MusicPage({
//     Key? key,
//     required Music music,
//   }) : super(key: key);

//   @override
//   _MusicPageState createState() => _MusicPageState();
// }

// class _MusicPageState extends State<MusicPage> {
//   AudioPlayer audioPlayer = AudioPlayer();

//   Container networkSongTmg(String imgDir) {
//     return Container(
//       width: context.widthPx * 0.85227,
//       height: context.widthPx * 0.85227 * 1.28378,
//       decoration: BoxDecoration(boxShadow: [
//         BoxShadow(
//           color: Color.fromRGBO(0, 0, 0, 0.3),
//           spreadRadius: 1,
//           blurRadius: 20,
//           offset: Offset(0, 0),
//         ),
//       ]),
//       child: Image(
//           width: double.infinity,
//           height: double.infinity,
//           image: FileImage(File(imgDir))),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: double.infinity,
//       color: Colors.white,
//       child: Column(
//         children: [
//           networkSongTmg(widget.music.image),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 width: context.widthPx * 0.073865,
//               ),
//               LikeButton(
//                 size: 40,
//                 animationDuration: const Duration(milliseconds: 500),
//                 circleColor: CircleColor(
//                     start: Color(0xff00ddff), end: Color(0xff0099cc)),
//                 bubblesColor: BubblesColor(
//                   dotPrimaryColor: Color(0xff33b5e5),
//                   dotSecondaryColor: Color(0xff0099cc),
//                 ),
//                 likeBuilder: (bool isLiked) {
//                   return Icon(
//                     isLiked
//                         ? Icons.pause_circle_outline
//                         : Icons.play_circle_outline,
//                     color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
//                     size: 40,
//                   );
//                 },
//                 onTap: playLocal,
//               ),
//               Expanded(child: SizedBox()),
//               Text(
//                 "Doja Cat; SZA \n Kiss Me More",
//                 style:
//                     TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 width: context.widthPx * 0.073865,
//               ),
//             ],
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: 10),
//             child: Container(
//               width: context.widthPx * 0.92,
//               height: 3,
//               decoration: BoxDecoration(
//                   color: Color.fromRGBO(0, 0, 0, 0.05),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color.fromRGBO(0, 0, 0, 0.05),
//                       spreadRadius: 1,
//                       blurRadius: 2,
//                       offset: Offset(0, 2),
//                     ),
//                   ]),
//             ),
//           ),
//           SizedBox(
//             height: 40,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               LikeButton(
//                 likeCount: 0,
//                 countBuilder: (int? count, bool isLiked, String texts) {
//                   var color = isLiked ? Color(0xFFF44336) : Colors.grey;
//                   Widget result;
//                   if (count == 0) {
//                     result = Text(
//                       "Like",
//                       style: TextStyle(color: color),
//                     );
//                   } else
//                     result = Text(
//                       texts,
//                       style: TextStyle(color: color),
//                     );
//                   return result;
//                 },
//                 likeBuilder: (bool isLiked) {
//                   return Icon(
//                     isLiked ? Icons.favorite : Icons.favorite_border,
//                     color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
//                     size: 30,
//                   );
//                 },
//               ),
//               SizedBox(
//                 width: (context.widthPx - (30 * 2 + 15 * 8)) * 4 / 7,
//               ),
//               LikeButton(
//                 size: 30,
//                 circleColor: CircleColor(
//                     start: Color(0xff00ddff), end: Color(0xff0099cc)),
//                 bubblesColor: BubblesColor(
//                   dotPrimaryColor: Color(0xff33b5e5),
//                   dotSecondaryColor: Color(0xff0099cc),
//                 ),
//                 likeCount: 0,
//                 countBuilder: (int? count, bool isLiked, String texts) {
//                   var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
//                   Widget result;
//                   if (count == 0) {
//                     result = Text(
//                       "Share",
//                       style: TextStyle(color: color),
//                     );
//                   } else
//                     result = Text(
//                       texts,
//                       style: TextStyle(color: color),
//                     );
//                   return result;
//                 },
//                 likeBuilder: (bool isLiked) {
//                   return Icon(
//                     Icons.share,
//                     color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
//                     size: 30,
//                   );
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
