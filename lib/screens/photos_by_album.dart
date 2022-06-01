import 'package:flutter/material.dart';
import 'package:flutter_assignment/models/albumByPhotos.dart';
import 'package:flutter_assignment/screens/user_albums.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../utils/colors.dart';

class PhotosByAlbumScreen extends StatefulWidget {
  final String albumId, userId;
  const PhotosByAlbumScreen({Key? key, required this.albumId, required this.userId}) : super(key: key);

  @override
  State<PhotosByAlbumScreen> createState() => _PhotosByAlbumScreenState();
}

class _PhotosByAlbumScreenState extends State<PhotosByAlbumScreen> with TickerProviderStateMixin{

  List<AlbumByPhotos> albumPhotoList = [];
  AnimationController? animationController;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    getUserAlbumPhotosList();
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  void getUserAlbumPhotosList() async {
    var response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/albums/${widget.albumId}/photos"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    setState(() {
      albumPhotoList = (json.decode(response.body) as List)
          .map((i) => AlbumByPhotos.fromJson(i))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          backgroundColor: AppColors.whiteColor,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: AppColors.blackColor,
            iconSize: 20.0,
            onPressed: () async{
              Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (context) => AlbumsScreen(userId: widget.userId)));
            },
          ),
          title: const Text(
            "Photos By Albums",
            style: TextStyle(
                color: AppColors.primaryColor,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
                fontSize: 14,
                letterSpacing: 0.2),
          ),
        ),
        body: SingleChildScrollView(
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: (2 / 2.7),
            crossAxisSpacing: 1,
            mainAxisSpacing: 2,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(5.0),
            children: List<Widget>.generate(
              albumPhotoList.length,
                  (int index) {
                final int count = albumPhotoList.length;
                final Animation<double> animation =
                Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: animationController!,
                    curve: Interval((1 / count) * index, 1.0,
                        curve: Curves.fastOutSlowIn),
                  ),
                );
                animationController?.forward();
                return AnimatedBuilder(
                    animation: animationController!,
                    builder: (BuildContext context, Widget? child) {
                      return FadeTransition(
                        opacity: animation,
                        child: Transform(
                          transform: Matrix4.translationValues(
                              0.0, 50 * (1.0 - animation.value), 0.0),
                          child: AspectRatio(
                            aspectRatio: 1.5,
                            child: GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                    children: [
                                      Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                margin:
                                                const EdgeInsets.only(
                                                    bottom: 42),
                                                decoration: BoxDecoration(
                                                  color:
                                                  AppColors.whiteColor,
                                                  border: Border.all(
                                                    color: AppColors
                                                        .closeIconColor,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                  const BorderRadius
                                                      .only(
                                                      topLeft: Radius
                                                          .circular(8),
                                                      topRight: Radius
                                                          .circular(8)),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Stack(
                                                        alignment: Alignment
                                                            .topRight,
                                                        children: <Widget>[
                                                            ClipRRect(
                                                                borderRadius: const BorderRadius
                                                                    .only(
                                                                    topLeft:
                                                                    Radius.circular(
                                                                        8),
                                                                    topRight:
                                                                    Radius.circular(8)),
                                                                child: Image(
                                                                    fit: BoxFit.fill,
                                                                    image: NetworkImage(
                                                                      albumPhotoList[index].url
                                                                          .toString(),
                                                                    ))),
                                                          /*Column(children: [
                                                            Container(
                                                              margin: const EdgeInsets
                                                                  .only(
                                                                  right: 10,
                                                                  top: 10),
                                                              width: 16,
                                                              height: 16,
                                                              decoration:
                                                              BoxDecoration(
                                                                border:
                                                                Border
                                                                    .all(
                                                                  color: AppColors
                                                                      .welcomeTextColor,
                                                                  width: 1,
                                                                ),
                                                                borderRadius: const BorderRadius
                                                                    .all(
                                                                    Radius.circular(
                                                                        2)),
                                                              ),
                                                              child: Center(
                                                                child: Image
                                                                    .asset(
                                                                  "assets/icons/icon_circle.png",
                                                                  scale: 3,
                                                                ),
                                                              ),
                                                            ),
                                                          ]),*/
                                                        ]),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      children: [
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            albumPhotoList[index].title
                                                                .toString(),
                                                            maxLines: 1,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            style: const TextStyle(
                                                                color: AppColors
                                                                    .textDarkColor,
                                                                fontSize:
                                                                10,
                                                                fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                                letterSpacing:
                                                                0,
                                                                fontFamily:
                                                                "Poppins",
                                                                fontStyle:
                                                                FontStyle
                                                                    .normal),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (context) => AlbumsScreen(userId: widget.userId)));
    return true;
  }
}
