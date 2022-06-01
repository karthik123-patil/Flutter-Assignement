import 'package:flutter/material.dart';
import 'package:flutter_assignment/screens/userlist_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../models/userTodos.dart';
import '../utils/colors.dart';
class UserToDosScreen extends StatefulWidget {
  final String userId;
  const UserToDosScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserToDosScreen> createState() => _UserToDosScreenState();
}

class _UserToDosScreenState extends State<UserToDosScreen> {

  List<UserTodos> userTodos = [];
  bool isShowMoreOrLess = true;
  bool isShowMoreWidget = false;
  @override
  void initState() {
    getUserPostList();
    super.initState();
  }

  void getUserPostList() async {
    var response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users/${widget.userId}/todos"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    setState(() {
      userTodos = (json.decode(response.body) as List)
          .map((i) => UserTodos.fromJson(i))
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
            "User Todos",
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
          itemCount: userTodos.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration:   BoxDecoration(
                      color: userTodos[index].completed! ? Colors.green : Colors.grey,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white70,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          userTodos[index].title.toString(),
                          style:   TextStyle(
                              color: userTodos[index].completed! ? AppColors.whiteColor: AppColors.blackColor,
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
