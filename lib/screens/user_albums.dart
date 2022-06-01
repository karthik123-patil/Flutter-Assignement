import 'package:flutter/material.dart';
import 'package:flutter_assignment/models/userAlbumList.dart';
import 'package:flutter_assignment/screens/photos_by_album.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_assignment/screens/userlist_screen.dart';
import 'package:http/http.dart' as http;

import '../utils/colors.dart';

class AlbumsScreen extends StatefulWidget {
  final String userId;
  const AlbumsScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  List<UserAlbumList> albumList = [];
  @override
  void initState() {
    getUserPostList();
    super.initState();
  }

  void getUserPostList() async {
    var response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users/${widget.userId}/albums"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    setState(() {
      albumList = (json.decode(response.body) as List)
          .map((i) => UserAlbumList.fromJson(i))
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
            "User Albums",
            style: TextStyle(
                color: AppColors.primaryColor,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
                fontSize: 14,
                letterSpacing: 0.2),
          ),
        ),
        body: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: albumList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (context) => PhotosByAlbumScreen(userId: widget.userId, albumId: albumList[index].id.toString(),)));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    color: Colors.lightGreen,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          albumList[index].title.toString(),
                          style: const TextStyle(
                              color: AppColors.whiteColor,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins",
                              fontSize: 14,
                              letterSpacing: 0.2),
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(color: AppColors.whiteColor,)
              ],
            );
          },
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (context) => UserListScreen()));
    return true;
  }
}
