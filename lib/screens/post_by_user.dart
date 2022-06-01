import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_assignment/models/userPost.dart';
import 'package:flutter_assignment/screens/userlist_screen.dart';
import 'package:http/http.dart' as http;

import '../utils/colors.dart';

class PostByUserScreen extends StatefulWidget {
  final String userId;
  const PostByUserScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<PostByUserScreen> createState() => _PostByUserScreenState();
}

class _PostByUserScreenState extends State<PostByUserScreen> {
  List<UserPost> userPost = [];
  bool isShowMoreOrLess = true;
  bool isShowMoreWidget = false;
  @override
  void initState() {
    getUserPostList();
    super.initState();
  }

  void getUserPostList() async {
    var response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users/${widget.userId}/posts"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    setState(() {
      userPost = (json.decode(response.body) as List)
          .map((i) => UserPost.fromJson(i))
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
              Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (context) => UserListScreen()));
            },
          ),
          title: const Text(
            "User Post",
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
          child: Column(
            children: [
              isShowMoreWidget?
              ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: userPost.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color:AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: AppColors.borderColor)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userPost[index].title.toString(),
                              style: const TextStyle(
                                  color: AppColors.blackColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.2,
                                  fontFamily: "Poppins",
                                  fontStyle: FontStyle.normal),
                            ),
                            Text(
                                userPost[index].body.toString(),
                              style: const TextStyle(
                                  color: AppColors.subTextColor,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.2,
                                  fontFamily: "Poppins",
                                  fontStyle: FontStyle.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ):
              ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color:AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: AppColors.borderColor)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userPost[index].title.toString(),
                              style: const TextStyle(
                                  color: AppColors.blackColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.2,
                                  fontFamily: "Poppins",
                                  fontStyle: FontStyle.normal),
                            ),
                            Text(
                              userPost[index].body.toString(),
                              style: const TextStyle(
                                  color: AppColors.subTextColor,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.2,
                                  fontFamily: "Poppins",
                                  fontStyle: FontStyle.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              Container(
                child: isShowMoreOrLess
                    ? InkWell(
                    onTap: () {
                      setState(() {
                        isShowMoreWidget = true;
                        isShowMoreOrLess = false;
                      });
                    },
                      child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isShowMoreWidget = true;
                            isShowMoreOrLess = false;
                          });
                        },
                        child:const Text(
                          "Show More",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.buttonBackgroundColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontFamily: "Poppins",
                              letterSpacing: 1),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                isShowMoreWidget = true;
                                isShowMoreOrLess = false;
                              });
                            },
                            child: Image.asset(
                              "assets/images/icon_more.png",
                              scale: 2,
                            )),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                  ],
                ),
                    )
                    : InkWell(
                      onTap: () {
                        setState(() {
                          isShowMoreWidget = false;
                          isShowMoreOrLess = true;
                        });
                      },
                      child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isShowMoreWidget = false;
                            isShowMoreOrLess = true;
                          });
                        },
                        child:const Text(
                          "Show Less",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.buttonBackgroundColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontFamily: "Poppins",
                              letterSpacing: 1),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                isShowMoreWidget = false;
                                isShowMoreOrLess = true;
                              });
                            },
                            child: Image.asset(
                              "assets/images/icon_less.png",
                              scale: 2,
                            )),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                  ],
                ),
                    ),
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (context) => UserListScreen()));
    return true;
  }
}
